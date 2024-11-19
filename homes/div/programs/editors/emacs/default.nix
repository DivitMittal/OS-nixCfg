{ pkgs, pkgs-darwin, config, ... }:

{
  programs.emacs = {
    enable = true;
    package = if pkgs.stdenvNoCC.hostPlatform.isDarwin then pkgs-darwin.emacs-nox else pkgs.emacs-nox;
  };

  home.file.doomEmacs = {
    enable = false;
    source = ./doom;
    target = "${config.xdg.configHome}/doom";
    recursive = true;
  };
}