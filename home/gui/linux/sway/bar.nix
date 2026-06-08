# Status bar: swaybar (ships with Sway, native tray) driven by i3status-rust.
#
# No separate bar process, no GTK/CSS. stylix themes swaybar; i3status-rust is given a plain
# theme and no icons (utilitarian, avoids missing-glyph boxes) unless stylix overrides.
{
  pkgs,
  lib,
  config,
  ...
}: let
  barConfig = "${config.xdg.configHome}/i3status-rust/config-top.toml";
in {
  programs.i3status-rust = {
    enable = true;

    bars.top = {
      theme = lib.mkDefault "plain";
      icons = lib.mkDefault "none";

      blocks = [
        {
          block = "cpu";
          interval = 5;
        }
        {
          block = "memory";
          format = " $mem_used_percents ";
        }
        {
          block = "disk_space";
          path = "/";
          info_type = "available";
          interval = 60;
          warning = 20.0;
          alert = 10.0;
        }
        {block = "net";}
        {block = "sound";}
        {
          block = "battery";
          interval = 30;
          missing_format = ""; # quietly hide on desktops without a battery
        }
        {
          block = "time";
          interval = 5;
          format = " $timestamp.datetime(f:'%a %F %T') ";
        }
      ];
    };
  };

  wayland.windowManager.sway.config.bars = [
    {
      position = "top";
      statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${barConfig}";
    }
  ];
}
