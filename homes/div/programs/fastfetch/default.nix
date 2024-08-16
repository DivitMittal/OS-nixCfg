{ pkgs, lib, ... }:

let
  fastfetch_macOS = pkgs.fastfetch.overrideAttrs {
    preBuild = lib.optionalString pkgs.stdenv.isDarwin "export MACOSX_DEPLOYMENT_TARGET=14.0";
  };
in
{
  programs.fastfetch = {
    enable = true;
    package = fastfetch_macOS;

    settings = {
      logo = {
        type = "iterm";
        source = "${./a-12.png}";

      };

      display = {
        separator = "➜❯";
        brightColor = true;

        key = {
          type = "both";
        };

        temp = {
          unit = "C";
          ndigits = "0";
        };
      };

      modules = [
        {
          type = "datetime";
          key = "Date";
          format = "{1}-{3}-{11}";
        }
        {
          type = "datetime";
          key = "Time";
          format = "{14}:{17}:{20}";
        }
        "break"
        "player"
        "media"
      ];
    };
  };
}