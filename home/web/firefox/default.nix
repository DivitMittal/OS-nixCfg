{
  pkgs,
  hostPlatform,
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
            (fx-autoconfig + /program/config.js)
          ];
        });
    inherit policies;
  };

  home.packages = [
    (pkgs.firefox-bin.override
      {
        extraFiles = {
          "defaults" = {
            source = fx-autoconfig + /program/defaults;
            recursive = true;
          };
          "config.js".source = fx-autoconfig + /program/config.js;
        };
      })
  ];
}
