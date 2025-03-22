{ pkgs, ... }:

let
  enable = false;
in
{
  programs.tmux = {
    inherit enable;
    package = pkgs.tmux;
  };

  xdg.configFile."tmux" = {
    inherit enable;
    source = ./conf;
    recursive = true;
  };
}