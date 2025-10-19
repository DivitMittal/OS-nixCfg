{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    img2pdf = pkgs.writeShellScriptBin "img2pdf" ''
      exec ${pkgs.uv}/bin/uvx img2pdf "$@"
    '';

    pdf-watermark = pkgs.writeShellScriptBin "pdf-watermark" ''
      exec ${pkgs.uv}/bin/uvx pdf-watermark "$@"
    '';
  };
}
