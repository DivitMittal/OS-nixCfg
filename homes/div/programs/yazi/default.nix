{ config, ... }:

{
  # TODO: add to nix-community/home-manager
  programs.yazi = {
    enable = true;
    enableFishIntegration = false; enableZshIntegration = false;
    settings = ./yazi.nix;
    keymap = ./keymap.nix;
    theme = ./theme.nix;
    # extraLuaConfig = builtins.readFile ./init.lua;
  };
  home.file = {
    initLua = {
      source = ./init.lua;
      target = "${config.xdg.configHome}/yazi/init.lua";
    };
    plugins = {
      source = ./plugins;
      target = "${config.xdg.configHome}/yazi/plugins";
      recursive = true;
    };
  };
}