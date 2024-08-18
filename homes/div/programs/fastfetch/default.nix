{ pkgs, lib, ... }:

# ff = ''fastfetch --logo-type iterm --logo ${./assets/a-12.png} \
#         --pipe false --title-color-user magenta --title-color-at blue --title-color-host red \
#         --structure Title:OS:Kernel:Uptime:Display:Terminal:CPU:CPUUsage:GPU:Memory:Swap:LocalIP \
#         --gpu-temp true --cpu-temp true --cpu-format "{1} @ {#4;35}{8}{#}" --gpu-format "{2} @ {#4;35}{4}{#}"'';
let
  fastfetch_macOS = pkgs.fastfetch.overrideAttrs {
    preBuild = lib.optionalString pkgs.stdenv.isDarwin "export MACOSX_DEPLOYMENT_TARGET=14.0";
  };
in
{
  programs.fish.shellInitLast = lib.mkAfter ''
    type -q fastfetch; and test "$TERM_PROGRAM" = "WezTerm"; and fastfetch
  '';

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