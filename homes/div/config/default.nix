{ config, pkgs, ...}:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
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

    # macOS only
    raycast = {
      enable = if isDarwin then true else false;
      source = ./raycast/scripts;
      target = "${config.xdg.configHome}/raycast/scripts";
      recursive = true;
    };

    # disabled
    hammerspoon = {
      enable = if isDarwin then false else false;
      source = ./hammerspoon/init.lua;
      target = "${config.xdg.configHome}/hammerspoon/init.lua";
    };

    karabiner-elements = {
      enable = if isDarwin then false else false;
      source = ./karabiner;
      target = "${config.xdg.configHome}/karabiner";
      recursive = true;
    };
  };
}