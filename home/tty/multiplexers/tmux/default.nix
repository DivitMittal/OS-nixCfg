{pkgs, ...}: let
  oh-my-tmux = pkgs.fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    rev = "af33f07134b76134acca9d01eacbdecca9c9cda6";
    hash = "sha256-nXm664l84YSwZeRM4Hsweqgz+OlpyfwXcgEdyNGhaGA=";
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
