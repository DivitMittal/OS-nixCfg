{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = false;
    package = pkgs.tmux;
  };

  home.file.tmux = {
    source = ./conf;
    target = "${config.xdg.configHome}/tmux";
    recursive = true;
  };
}