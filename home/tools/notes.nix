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
    onenote =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.microsoft-onenote
      else null;
  };
}