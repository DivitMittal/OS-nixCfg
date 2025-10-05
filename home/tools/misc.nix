{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ttyper
      czkawka-full
      ;
    gittype = pkgs.custom.gittype-bin;
    mac-cleanup = pkgs.writeShellScriptBin "mac-cleanup" ''
      exec ${pkgs.uv}/bin/uvx mac-cleanup "$@"
    '';
  };
}
