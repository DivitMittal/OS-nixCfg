{
  pkgs,
  hostPlatform,
  ...
}: {
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
      ## music
      #reaper-sws-extension
      #reaper-reapack-extension
      ;

    musescore =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.musescore
      else pkgs.musescore;
    # reaper =
    #   if hostPlatform.isDarwin
    #   then pkgs.brewCasks.reaper
    #   else pkgs.reaper;
  };
}
