{
  pkgs,
  lib,
  hostPlatform,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    localsend =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.localsend
      else pkgs.localsend;
  };
}
