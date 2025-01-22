{ config, ... }:

{
  home.file.ideavim = {
    enable = true;
    source = ./ideavimrc;
    target = "${config.xdg.configHome}/ideavim/ideavimrc";
  };
}