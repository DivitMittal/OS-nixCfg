# Session services: output management (kanshi), idle handling (swayidle), screen lock
# (swaylock). swaylock authenticates via the PAM service defined in the system desktop
# module. Lock screen colours come from stylix.
{
  pkgs,
  lib,
  ...
}: let
  mod = "Mod4";
  lock = "${pkgs.swaylock}/bin/swaylock -f";
  swaymsg = "${pkgs.sway}/bin/swaymsg";
in {
  # Declarative output profiles. The catch-all below just enables every connected output;
  # add per-machine profiles (criteria/mode/position/scale) here as needed.
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "default";
        profile.outputs = [
          {
            criteria = "*";
            status = "enable";
          }
        ];
      }
    ];
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = lock;
      }
      {
        timeout = 600;
        command = "${swaymsg} 'output * dpms off'";
        resumeCommand = "${swaymsg} 'output * dpms on'";
      }
    ];
    events = {
      "before-sleep" = lock;
      "lock" = lock;
    };
  };

  programs.swaylock = {
    enable = true;
    settings = {
      "show-failed-attempts" = true;
      "ignore-empty-password" = true;
    };
  };

  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    "${mod}+Shift+x" = "exec ${lock}";
  };
}
