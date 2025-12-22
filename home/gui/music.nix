{
  pkgs,
  lib,
  hostPlatform,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    # au-lab =
    #   if hostPlatform.isDarwin
    #   then
    #     (pkgs.brewCasks.au-lab.overrideAttrs (oldAttrs: {
    #       src = pkgs.fetchurl {
    #         url = lib.lists.head oldAttrs.src.urls;
    #         hash = "sha256-sjlpgwwtaF4ldr8EI3Cpzboai+7eYj8LvrBjWf7chFk=";
    #       };
    #     }))
    #   else null;
    # reaper =
    #   if hostPlatform.isDarwin
    #   then pkgs.brewCasks.reaper
    #   else pkgs.reaper;
    musescore =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.musescore
      else pkgs.musescore;

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
