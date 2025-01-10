{ pkgs, pkgs-darwin, config, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  programs.emacs = {
    enable = true;
    package = if isDarwin then pkgs-darwin.emacs-nox else pkgs.emacs-nox;
  };

  home.file.doomEmacs = {
    enable = false;
    source = ./doom;
    target = "${config.xdg.configHome}/doom";
    recursive = true;
  };
}