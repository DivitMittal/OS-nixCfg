{pkgs, ...}: {
  home.packages = let
    mutt = pkgs.fetchFromGitHub {
      owner = "muttmua";
      repo = "mutt";
      rev = "master";
      hash = "sha256-GiN1WjHzTICFOFCEqb39MWGu3EfxE4uvgN7hpjdpfrI=";
    };
  in [
    # To authorize a Microsoft account (one-time per account):
    #   oauth2 --authorize --provider microsoft --client-id <CLIENT_ID> user@outlook.com
    # Thunderbird's production client ID (tenant: common):
    #   https://hg.mozilla.org/comm-central/file/tip/mailnews/base/src/OAuth2Providers.sys.mjs
    #   microsoft365ProductionAppId = "9e5f94bc-e8a4-4e73-b8be-63364c29d753"
    (pkgs.writeShellScriptBin "oauth2" ''
      exec ${pkgs.python3}/bin/python3 ${mutt}/contrib/mutt_oauth2.py "$@"
    '')
  ];
}
