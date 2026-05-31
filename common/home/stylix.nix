# Home-manager stylix integration.
# Palette + fonts + opacity sourced from lib/palette.nix (single source of truth).
# All stylix.targets.<app> defaults stay enabled — touch everything reachable.
{
  inputs,
  pkgs,
  ...
}: let
  palette = import ../../lib/palette.nix {inherit pkgs;};
in {
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix = {
    enable = true;
    autoEnable = true;
    inherit (palette) polarity base16Scheme opacity fonts;
    image = palette.wallpaper;
  };
}
