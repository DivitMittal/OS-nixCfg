{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs.stable)
      spotdl
      ;
  };
}
