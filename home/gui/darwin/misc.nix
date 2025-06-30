{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs.brewCasks)
      alt-tab # Alt-Tab replacement
      #gswitch # MUX switcher (use pmset instead)
      bluesnooze # turns bluetooth off when asleep
      spaceman # spaces in menubar for macOS
      #aldente # Battery Management
      #licecap # Screen GIF Capture
      ;
    inherit
      (pkgs.customDarwin)
      hot-bin # CPU temperature monitor for menubar
      menubar-dock-bin # macOS dock in menubar
      ;
  };
}
