{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
  };

  home.file.tmux = {
    source = ./conf;
    target = "${config.xdg.configHome}/tmux";
    recursive = true;
  };
}