{
  config,
  pkgs,
  ...
}: let
  mutt = pkgs.fetchFromGitHub {
    owner = "muttmua";
    repo = "mutt";
    rev = "master";
    sha256 = "sha256-y9tXDwG0nC1HLKDq0B6DONsM0/hkGjsylwjlVhHEutY=";
  };
in {
  home.file."${config.home.sessionVariables.BIN_HOME}/oauth2".source = mutt + /contrib/mutt_oauth2.py;
}
