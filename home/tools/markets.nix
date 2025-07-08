{
  lib,
  pkgs,
}: {
  home.packages = lib.attrsts.attrValues {
    inherit
      (pkgs)
      tickrs
      cointop
      ;
  };
}
