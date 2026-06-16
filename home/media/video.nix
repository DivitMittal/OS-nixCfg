{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit (pkgs) ffmpeg;
    # yt-dlp-ejs pnpm bundling is broken in nixpkgs-unstable as of 2026-06-09
    yt-dlp = pkgs.stable.yt-dlp;
  };
}
