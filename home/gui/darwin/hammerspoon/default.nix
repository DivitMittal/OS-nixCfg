{
  lib,
  pkgs,
  ...
}: let
  enable = false;
in {
  home.packages = lib.lists.optionals enable [pkgs.brewCasks.hammerspoon];

  xdg.configFile."hammerspoon/init.lua" = {
    inherit enable;
    source = ./init.lua;
  };
}