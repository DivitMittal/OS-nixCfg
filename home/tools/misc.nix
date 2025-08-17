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
      czkawka-full
      ;
    mac-cleanup =
      if hostPlatform.isDarwin
      then pkgs.customPypi.mac-cleanup
      else null;
  };
}
