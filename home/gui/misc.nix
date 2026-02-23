{
  pkgs,
  lib,
  hostPlatform,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    syncthing =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.syncthing-app
      else pkgs.syncthing;
  };
}
