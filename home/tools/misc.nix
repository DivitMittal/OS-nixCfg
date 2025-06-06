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
      cyme
      ;

    inherit
      (pkgs.customDarwin)
      cliclick-bin
      ;
  };
}
