{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      spotdl
      ;

    # spotify =
    #   if hostPlatform.isDarwin
    #   then pkgs.brewCasks.spotify
    #   else pkgs.spotify;
  };
}
