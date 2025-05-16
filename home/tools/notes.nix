{
  pkgs,
  hostPlatform,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    obsidian =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.obsidian
      else pkgs.obsidian;
  };
}
