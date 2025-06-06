{
  config,
  hostPlatform,
  pkgs,
  lib,
  ...
}: let
  enable = false;
in {
  home.packages = lib.lists.optionals enable [pkgs.bitwarden-cli];

  programs.rbw = {
    inherit enable;
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
