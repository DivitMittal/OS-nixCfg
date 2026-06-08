# Notifications (mako) + on-screen display (swayosd) for volume/brightness.
# Colours come from stylix; behaviour only here. mako has no animations.
{
  pkgs,
  lib,
  ...
}: let
  osd = "${pkgs.swayosd}/bin/swayosd-client";
in {
  services.mako = {
    enable = true;
    settings = {
      "default-timeout" = 5000;
      layer = "overlay";
      "border-size" = 1;
    };
  };

  services.swayosd.enable = true;

  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    # Volume / mic — routed through swayosd so each press shows an OSD bar.
    "XF86AudioRaiseVolume" = "exec ${osd} --output-volume raise";
    "XF86AudioLowerVolume" = "exec ${osd} --output-volume lower";
    "XF86AudioMute" = "exec ${osd} --output-volume mute-toggle";
    "XF86AudioMicMute" = "exec ${osd} --input-volume mute-toggle";
    # Backlight.
    "XF86MonBrightnessUp" = "exec ${osd} --brightness raise";
    "XF86MonBrightnessDown" = "exec ${osd} --brightness lower";
  };
}
