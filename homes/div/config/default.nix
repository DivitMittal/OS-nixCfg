{ config, pkgs, ...}:

{
  imports = [
    ./impure_links.nix
  ];

  home.file = {
    ideavim = {
      enable = true;
      source = ./ideavim/ideavimrc;
      target = "${config.xdg.configHome}/ideavim/ideavimrc";
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