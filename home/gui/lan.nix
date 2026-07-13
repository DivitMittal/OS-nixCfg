{
  lib,
  hostPlatform,
  pkgs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    syncthing =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.syncthing-app
      else pkgs.syncthing;

    localsend =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.localsend
      else pkgs.localsend;
  };
}
