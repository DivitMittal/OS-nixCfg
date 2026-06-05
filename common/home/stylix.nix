# Home-manager stylix integration.
# Palette + fonts + opacity sourced from lib/palette.nix (single source of truth).
# All stylix.targets.<app> defaults stay enabled — touch everything reachable.
{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  palette = import ../../lib/palette.nix {inherit pkgs;};
in {
  imports = [inputs.stylix.homeModules.stylix];

  stylix = {
    enable = true;
    autoEnable = true;
    inherit (palette) polarity base16Scheme opacity fonts;
    image = palette.wallpaper;
  };

  # gtk.gtk4.theme default changed in 26.05; keep legacy behaviour until stateVersion bumps.
  gtk.gtk4.theme = lib.mkDefault config.gtk.theme;

  # sioyek uses RGB 0.0-1.0 color format; stylix generates hex which is incompatible.
  # The custom colors in home/gui/viewers.nix are intentional — disable stylix's target.
  stylix.targets.sioyek.enable = false;
}
