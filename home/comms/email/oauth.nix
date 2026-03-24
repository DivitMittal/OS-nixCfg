{
  config,
  pkgs,
  ...
}: {
  home.file."${config.home.sessionVariables.BIN_HOME}/oauth2" = let
    mutt = pkgs.fetchFromGitHub {
      owner = "muttmua";
      repo = "mutt";
      rev = "master";
      hash = "sha256-GiN1WjHzTICFOFCEqb39MWGu3EfxE4uvgN7hpjdpfrI=";
    };
  in {
    enable = false;
    source = mutt + "/contrib/mutt_oauth2.py";
  };
}
