{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
  };

  home.file.tmux = {
    source = ./tmux;
    target = "${config.xdg.configHome}/tmux";
    recursive = true;
  };
}