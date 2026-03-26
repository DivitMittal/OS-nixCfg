{inputs, ...}: {
  imports = [inputs.noctalia.homeModules.default];

  programs.noctalia-shell = {
    enable = true;
    # Auto-start with the graphical Wayland session
    systemd.enable = true;

    settings = {
      bar = {
        position = "top";
        floating = true;
        backgroundOpacity = 0.9;
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
      mPrimary = "#00ffe7"; # neon cyan
      mSurface = "#0d0d1a"; # deep dark navy
      mSurfaceVariant = "#1a1a2e"; # dark blue-black
      mOnSurface = "#e0e0ff"; # soft white-blue
      mOnSurfaceVariant = "#ff2d78"; # hot magenta
    };
  };
}
