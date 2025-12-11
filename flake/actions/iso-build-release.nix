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
        common-actions
        ++ [
          {
            name = "Build NixOS ISO";
            run = "nix -vL build --accept-flake-config .#nixosConfigurations.iso.config.system.build.isoImage --impure --show-trace";
          }
          {
            name = "Prepare release artifacts";
            run = ''
              ISO_PATH=$(find result/iso -name "*.iso" -type f | head -n 1)
              ISO_NAME=$(basename "$ISO_PATH")
              echo "ISO_PATH=$ISO_PATH" >> $GITHUB_ENV
              echo "ISO_NAME=$ISO_NAME" >> $GITHUB_ENV

              sha256sum "$ISO_PATH" > "$ISO_PATH.sha256"

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
              name = "NixOS Custom ISO";
              body = "Custom NixOS ISO with home-manager integration. See README for usage instructions.";
              draft = false;
              prerelease = false;
              files = "\${{ env.ISO_PATH }}\n\${{ env.ISO_PATH }}.sha256";
            };
            env.GITHUB_TOKEN = "\${{ secrets.GITHUB_TOKEN }}";
          }
        ];
    };
  };
}
