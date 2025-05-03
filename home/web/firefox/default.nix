{
  pkgs,
  hostPlatform,
  lib,
  ...
}: let
  inherit (import ./policies.nix) policies;
  fx-autoconfig = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "fx-autoconfig";
    rev = "f1f61958491c18e690bed8e04e89dd3a8e4a6c4d";
    hash = "sha256-V/jY6cV8IQmQ3JvbOspsECPTlhPS6SEfS0j5SWUAcME=";
  };
in {
  imports = [
    ./tridactyl
    ./profiles
  ];
  _module.args = {
    inherit fx-autoconfig;
  };

  programs.firefox = {
    enable = true;
    package =
      if hostPlatform.isDarwin
      then null
      else
        (pkgs.firefox.override {
          extraPrefsFiles = [
            (builtins.fetchurl {
              url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/config.js";
              sha256 = "1mx679fbc4d9x4bnqajqx5a95y1lfasvf90pbqkh9sm3ch945p40";
            })
          ];
        });
    inherit policies;
  };

  ## github:MrOtherGuy/fx-autoconfig
  home.file."Applications/Homebrew Casks/Firefox.app/Contents/Resources/defaults" = lib.mkIf hostPlatform.isDarwin {
    source = fx-autoconfig + /program/defaults;
    recursive = true;
  };
  home.file."Applications/Homebrew Casks/Firefox.app/Contents/Resources/config.js" = lib.mkIf hostPlatform.isDarwin {
    source = fx-autoconfig + /program/config.js;
  };
}
