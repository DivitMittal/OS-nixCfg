{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.default;

    enabledCustomApps = with spicePkgs.apps; [
      marketplace
      lyricsPlus
      historyInSidebar
    ];

    experimentalFeatures = true;
  };
}
