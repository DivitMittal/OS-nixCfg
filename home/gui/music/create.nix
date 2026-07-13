{
  pkgs,
  hostPlatform,
  lib,
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

    ## Musescore Score Editor
    musescore =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.musescore
      else pkgs.musescore;
  };
}
