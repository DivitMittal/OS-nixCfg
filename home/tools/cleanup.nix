{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      kondo
      czkawka-full
      ;
    inherit
      (pkgs.customDarwin)
      mole-bin
      ;
    mac-cleanup = pkgs.writeShellScriptBin "mac-cleanup" ''
      exec ${pkgs.uv}/bin/uvx mac-cleanup "$@"
    '';
  };
}
