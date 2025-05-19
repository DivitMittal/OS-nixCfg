{
  pkgs,
  hostPlatform,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    outlook =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.microsoft-outlook
      else null;
  };
}