{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues (
    {
      inherit
        (pkgs.brewCasks)
        spaceman # spaces in menubar for macOS
        dockdoor # Alt-Tab replacement
        pearcleaner # macOS all-in-one cleaner
        hot # CPU temperature monitor for menubar
        #alt-tab # Alt-Tab replacement (using dockdoor instead)
        #gswitch # MUX switcher (using pmset instead)
        #bluesnooze # turns bluetooth off when asleep
        #aldente # Battery Management
        #licecap # Screen GIF capture for showcasing
        #keycastr # Keystroke visualizer
        #brilliant # Screen Anotation Tool
        ;
      inherit
        (pkgs.customDarwin)
        menubar-dock-bin # macOS dock in menubar
        SakuraWallpaper # Live wallpaper for macOS
        #MultiSoundChanger-bin # aggregate-output volume control in menubar
        #LibreScore-bin # Music notation ripper
        #Iris-bin # Webcam mirror
        #LosslessSwitcher-bin # Lossless audio toggle in menubar
        ;
    }
    // lib.optionalAttrs pkgs.stdenv.hostPlatform.isx86_64 {
      VoltageShift = pkgs.customDarwin.VoltageShift; # Intel-only undervolting CLI
    }
  );
}
