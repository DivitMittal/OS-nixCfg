# nix-darwin system-level stylix.
# Darwin's stylix surface is small (mostly fonts + a couple of system bits);
# the bulk of darwin host theming flows through home-manager's stylix module
# in common/home/stylix.nix.
{
  inputs,
  pkgs,
  ...
}: let
  palette = import ../../../lib/palette.nix {inherit pkgs;};
in {
  imports = [inputs.stylix.darwinModules.stylix];

  stylix = {
    enable = true;
    autoEnable = true;
    # Stylix release.nix is ahead of nix-darwin's label (26.11 vs 26.05);
    # no actual API mismatch — silence the spurious warning.
    enableReleaseChecks = false;
    inherit (palette) polarity base16Scheme opacity fonts;
    image = palette.wallpaper;
  };
}
