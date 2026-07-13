{
  lib,
  pkgs,
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
        UV_NO_BUILD=1 exec ${pkgs.uv}/bin/uv tool run --python 3.11 --with "numpy<2" backgroundremover "$@"
      '';
      negate = pkgs.writeShellScriptBin "negate" ''
        set -e

        if [ $# -eq 0 ]; then
            echo "Error: No argument provided. Please specify a directory or a file." >&2
            exit 1
        fi

        if [ -d "$1" ]; then
            image_files=$(${pkgs.fd}/bin/fd --type f --glob "*.{png,jpg,jpeg}" "$1")
        elif [ -f "$1" ]; then
            image_files="$1"
        else
            echo "Error: Argument must be a directory or a file" >&2
            exit 1
        fi

        # Process each image file
        echo "$image_files" | while IFS= read -r image_file; do
            [ -z "$image_file" ] && continue

            # Strip extension to get base name
            base_name=$(echo "$image_file" | sed -E 's/\.(png|jpe?g)$//')
            output_file="$base_name.jpg"

            # For in-place operations (jpg->jpg), use temp file to avoid corruption
            if [ "$image_file" = "$output_file" ]; then
                temp_file="$base_name.tmp.jpg"

                # Convert using temp file
                if ${pkgs.imagemagick}/bin/magick -verbose "$image_file" -negate "$temp_file"; then
                    mv "$temp_file" "$output_file"
                else
                    echo "Error: Failed to process $image_file" >&2
                    rm -f "$temp_file"
                fi
            else
                # Different format (e.g., png->jpg), convert and delete original
                if ${pkgs.imagemagick}/bin/magick -verbose "$image_file" -negate "$output_file"; then
                    rm "$image_file"
                else
                    echo "Error: Failed to process $image_file" >&2
                fi
            fi
        done
      '';
    }
    ++ lib.optionals pkgs.stdenvNoCC.hostPlatform.isDarwin [
      pkgs.pngpaste
    ];
}
