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
    musescore =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.musescore
      else pkgs.musescore;
    inherit (pkgs.custom) reaper-bin;

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
