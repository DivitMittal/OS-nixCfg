{
  lib,
  pkgs,
  config,
  ...
}: {
  home.packages = lib.lists.optionals config.xdg.configFile."hammerspoon".enable [pkgs.brewCasks.hammerspoon];

  # run once: defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
  xdg.configFile."hammerspoon" = {
    enable = true;
    source = ./config;
    recursive = true;
  };
}