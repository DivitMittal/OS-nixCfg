{ pkgs, ... }:

{
  imports = [
    ./find-tools
    ./pagers
    ./yazi
    ./bat.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      chafa imagemagick ffmpeg exif              # media
      pandoc tectonic-unwrapped poppler rich-cli # documents
      w3m                                        # web
      ouch                                       # archives
      hexyl                                      # binary & misc.
    ;
  };

  programs.jq = {
    enable = true;
    package = pkgs.jq;

    colors = {
      null = "1;30";
      false = "0;31";
      true = "0;32";
      numbers = "0;36";
      strings = "0;33";
      arrays = "1;35";
      objects = "1;37";
    };
  };

  programs.mpv = {
    enable = true;
    package = pkgs.hello; # Installed via Homebrew instead

    bindings = {
      "n" = "seek -10";
      "i" = "seek +10";
    };

    config = {
      force-window = true;
    };
  };
}