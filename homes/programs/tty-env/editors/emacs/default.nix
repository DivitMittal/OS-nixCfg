{ pkgs, config, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
  };

  home.file.doomEmacs = {
    enable = false;
    source = ./doom;
    target = "${config.xdg.configHome}/doom";
    recursive = true;
  };
}