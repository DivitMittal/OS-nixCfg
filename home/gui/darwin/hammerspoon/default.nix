{
  lib,
  pkgs,
  ...
}: let
  enable = false;
in {
  home.packages = lib.lists.optionals enable [pkgs.brewCasks.hammerspoon];

  # run once: defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
  xdg.configFile."hammerspoon/init.lua" = {
    inherit enable;
    source = ./init.lua;
  };
}
