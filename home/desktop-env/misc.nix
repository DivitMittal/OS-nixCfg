{
  pkgs,
  hostPlatform,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    onlyoffice =
      if hostPlatform.isDarwin
      then (pkgs.brewCasks.onlyoffice.override {variation = "sequoia";})
      else pkgs.onlyoffice;
  };
}