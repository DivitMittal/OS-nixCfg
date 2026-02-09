{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs.nixosStable)
      spotdl
      ;
  };
}
