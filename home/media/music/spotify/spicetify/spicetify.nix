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
}
