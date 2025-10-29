{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ttyper
      ;
    # gittype = pkgs.custom.gittype-bin;
  };
}
