{ config, ...}:

{
  home.file = {
    wezterm = {
      source = ./wezterm/wezterm.lua;
      target = "${config.xdg.configHome}/.config/wezterm/wezterm.lua";
    };
    screen = {
      source = ./screen/screenrc;
      target = "${config.home.sessionVariables.SCREENRC}";
    };
    nvim-nvchad = {
      source = ./nvim-nvchad/custom;
      target = "${config.xdg.configHome}/nvim/lua/custom";
      recursive = true;
    };
    # TODO: add this as program module to nix-community/home-manager
    ov = {
      source = ./ov/config.yaml;
      target = "${config.xdg.configHome}/ov/config.yaml";
    };
    ideavim = {
      source = ./ideavim/ideavimrc;
      target = "${config.xdg.configHome}/ideavim/ideavimrc";
    };
  };
}