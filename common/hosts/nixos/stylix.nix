# NixOS system-level stylix.
# Themes TTY console, GDM/SDDM, plymouth, system GTK, and other NixOS-only
# stylix targets. User-facing apps remain themed via common/home/stylix.nix.
{
  inputs,
  pkgs,
  ...
}: let
  palette = import ../../../lib/palette.nix {inherit pkgs;};
in {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix = {
    enable = true;
    autoEnable = true;
    inherit (palette) polarity base16Scheme opacity fonts;
    image = palette.wallpaper;
  };
}
