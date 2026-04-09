{
  config,
  pkgs,
  ...
}: let
  homeApps = "${config.home.homeDirectory}/Applications/Home Manager Apps";
  vscodePath = "${homeApps}/Visual Studio Code.app";
  nomacsPath = "${homeApps}/nomacs.app";
  mpvPath = "${homeApps}/mpv.app";
in {
  programs.infat = {
    enable = true;
    package = pkgs.infat;

    autoActivate = true;

    settings = {
      # Extension-based associations are disabled: macOS on this version resolves
      # most extensions to dynamic UTIs (dyn.*) which cannot be set via Launch Services (error -50).
      # Use type-based associations instead, which map to well-known Apple UTIs directly.

      types = {
        plain-text = "TextEdit";
        sourcecode = vscodePath;
        "c-source" = vscodePath;
        "cpp-source" = vscodePath;
        "objc-source" = vscodePath;
        shell = vscodePath;
        makefile = vscodePath;

        # Image types
        image = nomacsPath;
        "raw-image" = nomacsPath;

        # Media types
        audio = mpvPath;
        video = mpvPath;
        movie = mpvPath;
        "mp4-audio" = mpvPath;
        "mp4-movie" = mpvPath;
      };
    };
  };
}
