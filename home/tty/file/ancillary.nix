{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ouch # archives
      hexyl # binary & misc.

      ## Documents
      pandoc
      poppler # PDFs
      ;
    markitdown = pkgs.writeScriptBin "markitdown" ''
      exec ${pkgs.uv}/bin/uv tool run markitdown "$@"
    '';
    rich-cli = pkgs.writeScriptBin "rich" ''
      exec ${pkgs.uv}/bin/uv tool run --from rich-cli rich "$@"
    '';
  };
}
