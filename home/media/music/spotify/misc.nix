{
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    # inherit
    #   (pkgs)
    #   spotdl
    #   ;

    # spotify =
    #   if hostPlatform.isDarwin
    #   then pkgs.brewCasks.spotify
    #   else pkgs.spotify;
  };
}
