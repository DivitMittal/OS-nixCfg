{
  lib,
  inputs,
  hostPlatform,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${hostPlatform.system};
in {
  programs.spicetify = {
    enable = true;

    theme = lib.mkForce spicePkgs.themes.default;
    colorScheme = lib.mkForce "Base";

    enabledCustomApps = with spicePkgs.apps; [
      marketplace
      lyricsPlus
      historyInSidebar
    ];

    experimentalFeatures = true;
  };
}
