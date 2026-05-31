{
  inputs,
  pkgs,
  ...
}: let
  palette = import ../../../lib/palette.nix {inherit pkgs;};

  # Map noctalia's Material slots onto our shared base16 cyberpunk palette.
  # noctalia does not have a stylix target, so we hand-feed it the same hexes
  # stylix sees — keeps the desktop shell visually in sync with everything else.
  hex = name: "#${palette.base16Scheme.${name}}";
in {
  imports = [inputs.noctalia.homeModules.default];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;

    settings = {
      bar = {
        position = "top";
        floating = true;
        backgroundOpacity = palette.opacity.popups;
      };
      general = {
        animationSpeed = 1.0;
        radiusRatio = 1.0;
      };
      colorSchemes = {
        darkMode = true;
        useWallpaperColors = false;
      };
    };

    colors = {
      mPrimary = hex "base0C"; # neon cyan          (was #00ffe7)
      mSurface = hex "base00"; # pitch black        (was noctalia #0d0d1a)
      mSurfaceVariant = hex "base02"; # dark blue-black     (was #1a1a2e)
      mOnSurface = hex "base05"; # soft white-blue    (was #e0e0ff)
      mOnSurfaceVariant = hex "base0E"; # hot magenta        (was #ff2d78)
    };
  };
}
