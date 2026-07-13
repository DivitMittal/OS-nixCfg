{
  config,
  hostPlatform,
  pkgs,
  lib,
  ...
}: let
  bwEnable = false;
in {
  home.packages = lib.lists.optionals bwEnable [pkgs.bitwarden-cli] ++ [pkgs.cotp];

  programs.rbw = {
    inherit bwEnable;
    package = pkgs.rbw;

    settings = {
      email = config.hostSpec.email.personal;
      pinentry =
        if hostPlatform.isDarwin
        then pkgs.pinentry_mac
        else pkgs.pinentry;
    };
  };
}
