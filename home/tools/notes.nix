{
  pkgs,
  hostPlatform,
  ...
}: {
  home.packages = builtins.attrValues {
    obsidian =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.obsidian
      else pkgs.obsidian;
  };
}
