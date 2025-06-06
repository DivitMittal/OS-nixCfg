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
      #aldente
      ;
    inherit
      (pkgs.customDarwin)
      hot-bin
      menubar-dock-bin
      ;
  };
}