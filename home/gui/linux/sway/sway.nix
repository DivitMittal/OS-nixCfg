# Sway compositor — core window-manager config.
#
# Replaces the previous niri setup. Theming (colours/fonts/background) is supplied entirely
# by stylix (common/home/stylix.nix); this module is behaviour-only.
#
# Descriptive vertical tabs — the whole reason for this migration — ride the stock i3/sway
# binds that the home-manager module ships by default:
#   Mod+s  layout stacking   (vertical list of descriptive title bars)
#   Mod+w  layout tabbed      (horizontal tab strip)
#   Mod+e  layout toggle split
# App/utility binds are added next to their tools (launcher.nix, notify-osd.nix, tools.nix).
{pkgs, ...}: let
  mod = "Mod4"; # Super
  terminal = "wezterm";
  # TUI launcher floated in a wezterm window (see launcher.nix for the float rule + package).
  launcher = "wezterm start --class launcher -- sway-launcher-desktop";
in {
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway;
    wrapperFeatures.gtk = true;

    # stylix injects a font config that `sway --validate` can choke on in the build sandbox;
    # skip the build-time check (config is still validated at runtime on reload).
    checkConfig = false;

    config = {
      modifier = mod;
      inherit terminal;
      menu = launcher; # Mod+d runs this by default

      input."type:touchpad" = {
        tap = "enabled";
        natural_scroll = "enabled";
      };

      gaps = {
        inner = 0;
        outer = 0;
      };

      # Thin border, no wasted chrome. Titlebars stay on (module default) so `layout stacking`
      # renders its descriptive title list.
      window.border = 1;

      startup = [
        # PolicyKit agent for GUI privilege prompts.
        {command = "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent";}
        # Clipboard history watchers (picker lives in tools.nix).
        {command = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";}
        {command = "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store";}
      ];
    };
  };
}
