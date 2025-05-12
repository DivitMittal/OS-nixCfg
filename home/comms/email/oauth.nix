{
  config,
  pkgs,
  ...
}: let
  mutt = pkgs.fetchFromGitHub {
    owner = "muttmua";
    repo = "mutt";
    rev = "5fd040e3aa1f807db1cab4ca7d7ba5fc8d48722e";
    hash = "sha256-DyFCczkCQCV9egIY/gWNLGtcxlFEWpprBHGdIS8+OFU=";
  };
in {
  home.file."${config.home.sessionVariables.BIN_HOME}/oauth2".source = mutt + /contrib/mutt_oauth2.py;
}
