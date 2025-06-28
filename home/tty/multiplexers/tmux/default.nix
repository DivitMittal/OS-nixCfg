{pkgs, ...}: let
  oh-my-tmux = pkgs.fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    rev = "master";
    sha256 = "sha256-2mdbOKCiwkr3FgjjyThezL+VVf5nm3+04idMETBLeao=";
  };
  enable = false;
in {
  programs.tmux = {
    inherit enable;
    package = pkgs.tmux;
  };
  xdg.configFile."tmux/tmux.conf" = {
    inherit enable;
    source = oh-my-tmux + "/.tmux.conf";
  };
  xdg.configFile."tmux/tmux.conf.local" = {
    inherit enable;
    source = ./tmux.conf.local;
  };
}
