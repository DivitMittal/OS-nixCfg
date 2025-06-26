{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ttyper
      gcalcli
      ;

    inherit
      (pkgs.customDarwin)
      cliclick-bin
      ;
  };
}
