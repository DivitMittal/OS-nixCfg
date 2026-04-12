{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs.brewCasks)
      spaceman # spaces in menubar for macOS
      dockdoor # Alt-Tab replacement
      thunderbird # Email client
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
      Hot-bin # CPU temperature monitor for menubar
      menubar-dock-bin # macOS dock in menubar
      Pearcleaner-bin # macOS all-in-one cleaner
      SakuraWallpaper # Live wallpaper for macOS
      #MultiSoundChanger-bin # aggregate-output volume control in menubar
      #LibreScore-bin # Music notation ripper
      #Iris-bin # Webcam mirror
      #LosslessSwitcher-bin # Lossless audio toggle in menubar
      ;

    ## AI Tools
    handy = pkgs.brewCasks.handy.override {variation = "tahoe";};
    claude-desktop = pkgs.brewCasks.claude.overrideAttrs (oldAttrs: {
      installPhase =
        oldAttrs.installPhase
        + ''
          # Clean bin due to collision with claude-code
          rm -rf $out/bin
        '';
    });
  };
}
