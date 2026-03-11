{
  pkgs,
  lib,
  hostPlatform,
  ...
}: let
  ## REAPER plugin directory (platform-specific)
  pluginsDir =
    if hostPlatform.isDarwin
    then "Library/Application Support/REAPER/UserPlugins"
    else ".config/REAPER/UserPlugins";

  ## Arch suffix used in extension filenames; Darwin calls aarch64 "arm64"
  swsArch =
    if hostPlatform.isAarch64
    then
      (
        if hostPlatform.isDarwin
        then "arm64"
        else "aarch64"
      )
    else "x86_64";

  ext =
    if hostPlatform.isDarwin
    then "dylib"
    else "so";
in {
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

    ## Musescore Score Editor
    musescore =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.musescore
      else pkgs.musescore;

    ## Reaper DAW
    inherit (pkgs.custom) reaper-bin;

    ## Reaper Extensions
    inherit (pkgs) reaper-sws-extension reaper-reapack-extension;

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

  home.file = {
    "${pluginsDir}/reaper_sws-${swsArch}.${ext}".source = "${pkgs.reaper-sws-extension}/UserPlugins/reaper_sws-${swsArch}.${ext}";

    "${pluginsDir}/reaper_reapack-${swsArch}.${ext}".source = "${pkgs.reaper-reapack-extension}/UserPlugins/reaper_reapack-${swsArch}.${ext}";
  };
}
