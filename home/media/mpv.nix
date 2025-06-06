{
  pkgs,
  hostPlatform,
  ...
}: {
  programs.mpv = {
    enable = false;
    package =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.stolendata-mpv
      else pkgs.mpv-unwrapped;

    bindings = {
      "n" = "seek -10";
      "i" = "seek +10";
    };

    config = {
      force-window = true;
    };
  };
}