{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  home.packages = [pkgs.kanata-with-cmd];

  xdg.configFile."karabiner" = {
    enable = false;
    source = inputs.TLTR + "/karabiner";
    recursive = true;
  };
}