{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs.brewCasks)
      alt-tab
      gswitch
      bluesnooze
      spaceman
      ;
  };
}