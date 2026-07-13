{
  inputs,
  hostPlatform,
  lib,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${hostPlatform.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;

    theme = lib.mkForce spicePkgs.themes.text;
    colorScheme = lib.mkForce "Spotify";

    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
      adblockify
      songStats
    ];

    enabledSnippets = with spicePkgs.snippets; [
      beSquare
    ];

    enabledCustomApps = with spicePkgs.apps; [
      marketplace
      lyricsPlus
      historyInSidebar
    ];

    experimentalFeatures = true;
  };

  home.packages = lib.attrsets.attrValues {
    # spotify =
    #   if hostPlatform.isDarwin
    #   then
    #     (pkgs.brewCasks.spotify.override {
    #       variation = "tahoe";
    #     }).overrideAttrs (oldAttrs: {
    #       src = pkgs.fetchurl {
    #         url = lib.lists.head oldAttrs.src.urls;
    #         hash = "sha256-4Lm4g0gAQ3EA7Sj2wDTbjEXRxcNoGWHLvdEx/57nry4=";
    #       };
    #     })
    #   else pkgs.spotify;
  };
}
