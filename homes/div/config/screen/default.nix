{ config, ... }:

{
  home.file.screen = {
    source = ./screenrc;
    target = "${config.home.sessionVariables.SCREENRC}";
  };
}