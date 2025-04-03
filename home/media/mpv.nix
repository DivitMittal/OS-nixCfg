{
  pkgs,
  hostPlatform,
  ...
}: {
  programs.mpv = {
    enable = true;
    package =
      if hostPlatform.isDarwin
      then pkgs.hello
      else pkgs.mpv-unwrapped; # homebrew

    bindings = {
      "n" = "seek -10";
      "i" = "seek +10";
    };

    config = {
      force-window = true;
    };
  };
}
