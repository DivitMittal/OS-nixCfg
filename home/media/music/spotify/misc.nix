{
  lib,
  pkgs,
  hostPlatform,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      spotdl
      ;

    spotify =
      if hostPlatform.isDarwin
      then
        (pkgs.brewCasks.spotify.override {
          variation = "tahoe";
        }).overrideAttrs (oldAttrs: {
          src = pkgs.fetchurl {
            url = lib.lists.head oldAttrs.src.urls;
            hash = "sha256-N2tQTS9vHp93cRI0c5riVZ/8FSaq3ovDqh5K9aU6jV0=";
          };
        })
      else pkgs.spotify;
  };
}
