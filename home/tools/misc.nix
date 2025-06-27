{
  pkgs,
  lib,
  hostPlatform,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ttyper
      ;
    mac-cleanup =
      if hostPlatform.isDarwin
      then pkgs.customPypi.mac-cleanup
      else null;
  };
}
