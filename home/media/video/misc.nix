{
  lib,
  pkgs,
  ...
}: {
  home.packmages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ffmpeg
      yt-dlp
      ;
  };
}
