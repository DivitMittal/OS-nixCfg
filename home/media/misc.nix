{ pkgs, ... }:

{
  home.packages = builtins.attrValues {
    inherit(pkgs)
      ## video
      ffmpeg
      yt-dlp

      ## image
      #chafa
      imagemagick
      exif

      ##m music
      reaper
      #musescore  ## bad build binary on darwin systems using homemanager
    ;
  };
}