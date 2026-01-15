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
      #bluesnooze # turns bluetooth off when asleep
      spaceman # spaces in menubar for macOS
      #aldente # Battery Management
      #licecap # Screen GIF Capture
      #keycastr # Keystroke visualizer
      #thunderbird # Email client
      #brilliant # Screen Anotation Tool
      ;
    handy = pkgs.brewCasks.handy.override {variation = "tahoe";};
    inherit
      (pkgs.customDarwin)
      hot-bin # CPU temperature monitor for menubar
      menubar-dock-bin # macOS dock in menubar
      MultiSoundChanger-bin # aggregate-output volume control in menubar
      LibreScore-bin # Music notation ripper
      iris # Webcam mirror
      #codexbar-bin # AI usage limits in menubar
      #LosslessSwitcher-bin # Lossless audio toggle in menubar
      ;

    # claude-desktop = pkgs.brewCasks.claude.overrideAttrs (oldAttrs: {
    #   installPhase =
    #     oldAttrs.installPhase
    #     + ''
    #       # Clean bin due to collision with claude-code
    #       rm -rf $out/bin
    #     '';
    # });
  };
}
