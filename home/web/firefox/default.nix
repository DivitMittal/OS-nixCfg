{
  config,
  pkgs,
  hostPlatform,
  lib,
  inputs,
  ...
}: let
  inherit (import ./policies.nix) policies;
  inherit (import ./profiles.nix {inherit pkgs;}) profiles;
  fx-autoconfig = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "fx-autoconfig";
    rev = "master";
    hash = "sha256-NUGFGlf7HdZUVNmK3Hk5xbRGIKzg3QJVXO5kM44Xqy0=";
  };
in {
  imports = [
    inputs.betterfox.homeManagerModules.betterfox
  ];

  ## Firefox
  programs.firefox = {
    enable = true;
    betterfox.enable = true;
    ## bad built binary on darwin systems
    # package = (pkgs.firefox.override {
    #   extraPrefsFiles = [
    #     (builtins.fetchurl {
    #       url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/config.js";
    #       sha256 = "1mx679fbc4d9x4bnqajqx5a95y1lfasvf90pbqkh9sm3ch945p40";
    #     })
    #   ];
    # });
    package = null; # homebrew
    nativeMessagingHosts = with pkgs; [tridactyl-native];
    inherit policies;
    inherit profiles;
  };

  ## Mercury (firefox-fork)
  # programs.librewolf = {
  #   enable = true;
  #   package = null; # binary
  #
  #   name = "mercury";
  #   configPath = if hostPlatform.isDarwin then "Library/Application Support/mercury" else ".mozilla";
  #
  #   nativeMessagingHosts = with pkgs;[ tridactyl-native ];
  #
  #   inherit profiles;
  # };
  # home.file.MercuryUserChromeJS = {
  #   source = ./chrome/JS;
  #   target = "${config.programs.librewolf.configPath}" + (if hostPlatform.isDarwin then "/Profiles" else "") + "/custom-default/chrome/JS";
  #   recursive = true;
  # };

  xdg.configFile."tridactyl" = {
    source = ./tridactyl;
    recursive = true;
  };

  home.file.firefoxUserChromeJS = {
    enable = true;
    source = ./chrome/JS;
    target = "${config.programs.firefox.configPath}" + lib.optionalString hostPlatform.isDarwin "/Profiles" + "/custom-default/chrome/JS";
    recursive = true;
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
