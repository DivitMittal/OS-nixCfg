{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ## video
      ffmpeg
      yt-dlp
      ## image
      #chafa
      imagemagick
      exif
      ##m music
      reaper
      #reaper-sws-extension # broken
      #reaper-reapack-extension
      #musescore  ## bad build binary on darwin systems using homemanager
      ;
  };
}
