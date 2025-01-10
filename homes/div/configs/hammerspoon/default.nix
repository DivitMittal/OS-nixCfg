{ config, ... }:

{
  home.file.hammerspoon = {
    enable = true;
    source = ./init.lua;
    target = "${config.xdg.configHome}/hammerspoon/init.lua";
  };
}