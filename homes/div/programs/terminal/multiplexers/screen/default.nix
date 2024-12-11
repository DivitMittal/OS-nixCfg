{ config, ... }:

{
  home.sessionVariables.SCREENRC = "${config.xdg.configHome}/screen/screenrc";

  home.file.screen = {
    enable = true;
    source = ./screenrc;
    target = "${config.home.sessionVariables.SCREENRC}";
  };
}