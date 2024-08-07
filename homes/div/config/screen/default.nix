{ config, ... }:

{
  home.sessionVariables.SCREENRC = "${config.xdg.configHome}/screen/screenrc";
  home.file.screen = {
    source = ./screenrc;
    target = "${config.home.sessionVariables.SCREENRC}";
  };
}