{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs.brewCasks)
      alt-tab
      gswitch
      bluesnooze
      spaceman
      ;
    inherit
      (pkgs.customDarwin)
      cliclick-bin
      hot-bin
      menubar-dock-bin
      ;
  };
}
