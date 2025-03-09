{ pkgs, config, ... }:

let
  enableToggle = false;
in
{
  programs.emacs = {
    enable = enableToggle;
    package = pkgs.emacs-nox;
  };

  xdg.configFile."doom" = {
    enable = enableToggle;
    source = ./doom;
    recursive = true;
  };
}