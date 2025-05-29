_:
# let
#   oh-my-tmux = pkgs.fetchFromGitHub {
#     owner = "gpakosz";
#     repo = ".tmux";
#     rev = "master";
#     sha256 = "sha256-2mdbOKCiwkr3FgjjyThezL+VVf5nm3+04idMETBLeao=";
#   };
# in
{
  # programs.tmux = {
  #   enable = true;
  #   package = pkgs.tmux;
  # };
  # xdg.configFile."tmux/tmux.conf" = {
  #   source = oh-my-tmux + "/.tmux.conf";
  # };
  # xdg.configFile."tmux/tmux.conf.local" = {
  #   source = ./tmux.conf.local;
  # };
}