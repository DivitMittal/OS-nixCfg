{pkgs, ...}: let
  oh-my-tmux = pkgs.fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    rev = "124f5fc36dbca79a840d14f898d751c96ed9a1e7";
    hash = "sha256-XXiyPSvrrtZgQ1IN797O1vgZDkwppKImgL+OQE507Fs=";
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
