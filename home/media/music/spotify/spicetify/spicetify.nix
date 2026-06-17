{
  inputs,
  hostPlatform,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${hostPlatform.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.text;
    colorScheme = "Spotify";

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
