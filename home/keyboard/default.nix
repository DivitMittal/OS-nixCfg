{
  pkgs,
  lib,
  ...
}: let
  TLTR = pkgs.fetchFromGitHub {
    owner = "DivitMittal";
    repo = "TLTR";
    rev = "c18d25661936b0e612d3e9fed74719a6315e53ef";
    hash = "sha256-P6FqVAzBr6Nza1iPMzMj9HTR23w2HqV1iQY0/nbLuXg=";
  };
in {
  _module.args = {
    inherit TLTR;
  };
  imports = lib.custom.scanPaths ./.;

  home.packages = [pkgs.kanata-with-cmd];

  xdg.configFile."karabiner" = {
    enable = false;
    source = TLTR + "/karabiner";
    recursive = true;
  };
}