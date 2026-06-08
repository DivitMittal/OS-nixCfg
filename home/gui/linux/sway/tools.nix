# Desktop utilities: screenshots, clipboard history, brightness, media keys, screen
# recording, and the PolicyKit agent package. Keybinds wire them into Sway.
{
  pkgs,
  lib,
  ...
}: let
  mod = "Mod4";
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";
  satty = "${pkgs.satty}/bin/satty";
  cliphist = "${pkgs.cliphist}/bin/cliphist";
  wlcopy = "${pkgs.wl-clipboard}/bin/wl-copy";
  fzf = "${pkgs.fzf}/bin/fzf";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
in {
  home.packages = [
    pkgs.grim
    pkgs.slurp
    pkgs.satty
    pkgs.wl-clipboard
    pkgs.cliphist
    pkgs.brightnessctl
    pkgs.playerctl
    pkgs.wf-recorder
    pkgs.lxqt.lxqt-policykit
  ];

  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    # Region screenshot → satty for annotation.
    "Print" = ''exec ${grim} -g "$(${slurp})" - | ${satty} --filename -'';
    # Full screenshot → clipboard.
    "Shift+Print" = "exec ${grim} - | ${wlcopy}";
    # Clipboard history picker (fzf in a floating wezterm).
    "${mod}+v" = ''exec wezterm start --class launcher -- sh -c '${cliphist} list | ${fzf} | ${cliphist} decode | ${wlcopy}' '';

    # Media keys.
    "XF86AudioPlay" = "exec ${playerctl} play-pause";
    "XF86AudioNext" = "exec ${playerctl} next";
    "XF86AudioPrev" = "exec ${playerctl} previous";
    "XF86AudioStop" = "exec ${playerctl} stop";
  };
}
