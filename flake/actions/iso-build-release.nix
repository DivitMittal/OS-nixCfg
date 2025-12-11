{
  common-permissions,
  environment,
  common-actions,
  ...
}: {
  flake.actions-nix.workflows.".github/workflows/iso-build-release.yml" = {
    on = {
      push = {
        branches = ["master"];
        tags = ["iso-*"];
      };
      workflow_dispatch = {};
    };

    jobs.build-and-release-iso = {
      permissions =
        common-permissions
        // {
          contents = "write";
        };
      inherit environment;

      steps =
        [
          {
            name = "Checkout repo";
            uses = "actions/checkout@main";
            "with" = {
              fetch-depth = 1;
              persist-credentials = true; # Enable credentials for tag push
            };
          }
        ]
        ++ (builtins.tail common-actions) # Skip the common checkout action
        ++ [
          {
            name = "Build NixOS ISO";
            run = "nix -vL build --accept-flake-config .#nixosConfigurations.iso.config.system.build.isoImage --impure --show-trace";
          }
          {
            name = "Prepare release artifacts";
            run = ''
              # Find the ISO in the Nix store result
              ISO_PATH=$(find result/iso -name "*.iso" -type f | head -n 1)
              ISO_NAME=$(basename "$ISO_PATH")

              # Create artifacts directory
              mkdir -p artifacts
              cd artifacts

              # Compress the ISO with xz for better compression
              echo "Compressing ISO..."
              xz -9 -T0 -c "$ISO_PATH" > "$ISO_NAME.xz"

              # Split compressed ISO into parts <1.9GB each (leaving margin under 2GB)
              echo "Splitting compressed ISO into parts..."
              split -b 1900M -d "$ISO_NAME.xz" "$ISO_NAME.xz.part"

              # Generate SHA256 checksums for each part
              echo "Generating checksums..."
              for part in "$ISO_NAME.xz.part"*; do
                sha256sum "$part" > "$part.sha256"
              done

              # Create reconstruction instructions
              cat > INSTALL.txt << 'EOF'
              # NixOS ISO Installation Instructions

              ## Reconstructing the ISO

              1. Download all parts (.part00, .part01, etc.) and their checksums
              2. Verify checksums:
                 sha256sum -c *.sha256
              3. Reconstruct the compressed ISO:
                 cat *.part* > nixos-custom.iso.xz
              4. Decompress:
                 unxz nixos-custom.iso.xz
              5. Write to USB:
                 sudo dd if=nixos-custom.iso of=/dev/sdX bs=4M status=progress

              Or use one command:
                 cat *.part* | unxz | sudo dd of=/dev/sdX bs=4M status=progress
              EOF

              # List all part files for release upload
              ls -lh "$ISO_NAME.xz.part"* > parts.txt
              echo "ISO_PARTS=$(ls "$ISO_NAME.xz.part"* | tr '\n' ' ')" >> $GITHUB_ENV

              cd ..

              # Set environment variables
              echo "ISO_NAME=$ISO_NAME" >> $GITHUB_ENV
              TAG_NAME="iso-$(date -u +%Y%m%d-%H%M%S)"
              echo "TAG_NAME=$TAG_NAME" >> $GITHUB_ENV
            '';
          }
          {
            name = "Create release tag";
            run = ''
              git config user.name "github-actions[bot]"
              git config user.email "github-actions[bot]@users.noreply.github.com"
              git tag -a "$TAG_NAME" -m "NixOS ISO Release $TAG_NAME"
              git push origin "$TAG_NAME"
            '';
          }
          {
            name = "Create GitHub Release";
            uses = "softprops/action-gh-release@v1";
            "with" = {
              tag_name = "\${{ env.TAG_NAME }}";
              name = "NixOS Custom ISO - \${{ env.ISO_NAME }}";
              body = ''
                # NixOS Custom ISO with Home-Manager Integration

                **ISO Name:** `''${{ env.ISO_NAME }}`

                ## Download Instructions

                This ISO has been compressed with XZ and split into multiple parts to stay under GitHub's 2GB limit.

                ### Quick Install (Linux/macOS):
                ```bash
                # Download all files, then:
                cat *.part* | unxz | sudo dd of=/dev/sdX bs=4M status=progress
                ```

                ### Manual Reconstruction:
                1. Download all `.part*` files and their `.sha256` checksums
                2. Verify integrity: `sha256sum -c *.sha256`
                3. Reconstruct: `cat *.part* > nixos-custom.iso.xz`
                4. Decompress: `unxz nixos-custom.iso.xz`
                5. Write to USB: `sudo dd if=nixos-custom.iso of=/dev/sdX bs=4M status=progress`

                See `INSTALL.txt` for detailed instructions.

                ## Included Features
                - NixOS minimal installation CD
                - Home-Manager integration
                - Terminal tools from home/tty configuration
                - SSH enabled (password: nixos)
              '';
              draft = false;
              prerelease = false;
              files = "artifacts/*";
            };
            env.GITHUB_TOKEN = "\${{ secrets.GITHUB_TOKEN }}";
          }
        ];
    };
  };
}
