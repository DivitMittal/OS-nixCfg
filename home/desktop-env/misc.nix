{
  pkgs,
  hostPlatform,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    onlyoffice =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.onlyoffice
      else pkgs.onlyoffice;
  };
}
