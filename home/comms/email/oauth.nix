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
      hash = "sha256-qiujvWDOTv2fa9Go4Txxy681v7eogZPQcoooCuaAArM=";
    };
  in {
    enable = false;
    source = mutt + "/contrib/mutt_oauth2.py";
  };
}
