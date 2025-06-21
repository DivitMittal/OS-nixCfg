{
  pkgs,
  lib,
  hostPlatform,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      # reaper-sws-extension
      # reaper-reapack-extension
      ;
    inherit
      (pkgs.brewCasks)
      au-lab
      ;
    # reaper =
    #   if hostPlatform.isDarwin
    #   then pkgs.brewCasks.reaper
    #   else pkgs.reaper;
    musescore =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.musescore
      else pkgs.musescore;
  };
}
