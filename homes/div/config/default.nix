{ config, pkgs, ...}:

{
  home.file = {
    ideavim = {
      enable = true;
      source = ./ideavim/ideavimrc;
      target = "${config.xdg.configHome}/ideavim/ideavimrc";
    };

    wezterm = {
      enable = true;
      source = ./wezterm/wezterm.lua;
      target = "${config.xdg.configHome}/wezterm/wezterm.lua";
    };

    raycast = {
      enable = true;
      source = ./raycast/scripts;
      target = "${config.xdg.configHome}/raycast/scripts";
      recursive = true;
    };

    # disabled
    hammerspoon = {
      enable = false;
      source = ./hammerspoon/init.lua;
      target = "${config.xdg.configHome}/hammerspoon/init.lua";
    };

    karabiner-elements = {
      enable = false;
      source = ./karabiner;
      target = "${config.xdg.configHome}/karabiner";
      recursive = true;
    };

    zed = {
      enable = false;
      source = ./karabiner;
      target = "${config.xdg.configHome}/zed";
      recursive = true;
    };
  };
}