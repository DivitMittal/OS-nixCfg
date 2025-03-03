{ pkgs, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  imports = [
    ./spotify
  ];

  home.packages = builtins.attrValues {
    inherit(pkgs)
      # video
      ffmpeg yt-dlp

      # image
      chafa imagemagick exif
    ;
  };

  programs.mpv = {
    enable = true;
    package = (if isDarwin then pkgs.hello else pkgs.mpv-unwrapped); # homebrew

    bindings = {
      "n" = "seek -10";
      "i" = "seek +10";
    };

    config = {
      force-window = true;
    };
  };
}