{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      #chafa
      imagemagick
      exif # metadata
      ;
    bgrm = pkgs.writeShellScriptBin "bgrm" ''
      exec ${pkgs.uv}/bin/uv tool run --python 3.11 --with "numpy<2" backgroundremover "$@"
    '';
  };

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
}
