{ pkgs, config, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
  };

  home.file.doomEmacs = {
    source = ./doom;
    target = "${config.xdg.configHome}/doom";
    recursive = true;
  };
}