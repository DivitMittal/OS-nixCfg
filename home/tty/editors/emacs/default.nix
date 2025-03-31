{ pkgs, ... }:

let
  enable = false;
in
{
  programs.emacs = {
    inherit enable;
    package = pkgs.emacs-nox;
  };

  xdg.configFile."doom" = {
    inherit enable;
    source = ./doom;
    recursive = true;
  };
}