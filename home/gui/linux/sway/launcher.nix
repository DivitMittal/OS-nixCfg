# Launcher: sway-launcher-desktop — a TUI/fzf desktop launcher run inside a floating wezterm.
# Bound to Mod+d via config.menu (set in sway.nix). Plus sway-easyfocus for label-jump focus.
{
  pkgs,
  lib,
  ...
}: let
  mod = "Mod4";
in {
  home.packages = [pkgs.sway-launcher-desktop];

  programs.sway-easyfocus.enable = true;

  wayland.windowManager.sway.config = {
    # Float + centre the launcher terminal (wezterm started with --class launcher).
    window.commands = [
      {
        criteria.app_id = "launcher";
        command = "floating enable, resize set 50 ppt 60 ppt, move position center";
      }
    ];

    keybindings = lib.mkOptionDefault {
      "${mod}+a" = "exec ${pkgs.sway-easyfocus}/bin/sway-easyfocus";
    };
  };
}
