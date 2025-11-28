{
  lib,
  pkgs,
  hostPlatform,
  ...
}: {
  home.packages =
    lib.attrsets.attrValues {
      inherit
        (pkgs)
        #chafa
        imagemagick
        exif # metadata
        ;
      bgrm = pkgs.writeShellScriptBin "bgrm" ''
        exec ${pkgs.uv}/bin/uv tool run --python 3.11 --with "numpy<2" backgroundremover "$@"
      '';
    }
    ++ lib.optionals pkgs.stdenvNoCC.hostPlatform.isDarwin [pkgs.customDarwin.nomacs-bin];

  programs.fish.functions = {
    negate = ''
      if test (count $argv) -eq 0
          echo "Error: No argument provided. Please specify a directory or a file."
          exit 1
      end

      if test -d $argv[1]
          set image_files (${pkgs.fd}/bin/fd --type f --glob "*.{png,jpg,jpeg}" $argv[1])
      else if test -f $argv[1]
          set image_files $argv[1]
      else
          echo "Error: Argument must be a directory or a file"
          exit 1
      end

      for image_file in $image_files
          set -l base_name (string replace -r '\.(png|jpe?g)$' ''' "$image_file")

          ${pkgs.imagemagick}/bin/magick -verbose "$image_file" -negate "$base_name.jpg"

          rm $image_file
      end
    '';
  };

  home.activation = lib.mkIf hostPlatform.isDarwin {
    importNomacsSettings = lib.hm.dag.entryAfter ["installPackages"] ''
      if command -v nomacs >/dev/null 2>&1; then
        $DRY_RUN_CMD ${pkgs.customDarwin.nomacs-bin}/bin/nomacs --import-settings ${./nomacs-settings.ini}
        echo "Imported nomacs settings"
      fi
    '';
  };
}
