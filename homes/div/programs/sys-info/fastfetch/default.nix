{ pkgs, pkgs-darwin, lib, ... }:

# let
#   fastfetch_macOS = pkgs.fastfetch.overrideAttrs {
#     preBuild = lib.optionalString pkgs.stdenv.isDarwin "export MACOSX_DEPLOYMENT_TARGET=14.0";
#   };
# in
{
  programs.fish.shellInitLast = ''
    test "$TERM_PROGRAM" = "WezTerm"; and fastfetch
  '';

  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;

    settings = {
      logo = {
        type = "iterm";
        source = "${./a-12.png}";
      };
      display = {
        pipe = false;
        hideCursor = true;
        separator = " -➜❯ ";
        brightColor = true;
        constants =  [
          "───────────────────----────────"
        ];
        color = {
          keys = "light_magenta";
          separator = "light_white";
          title = "white";
          output  = "light_white";
        };
        key = {
          type = "both";
          paddingLeft = 0;
        };
        size = {
          binaryPrefix = "iec";
          ndigits = 2;
        };
        temp = {
          unit = "C";
          ndigits = 0;
        };
        percent = {
          type = 9;
          ndigits = 0;
        };
        freq = {
          ndigits = 2;
        };
      };

      modules = [
        {
          type = "Custom";
          format = "┌{$1} info {$1}┐";
        }
        {
          type = "OS";
          keyColor = "light_blue";
        }
        {
          type = "Kernel";
          keyColor = "light_blue";
        }
        {
          type = "Display";
          key = "Resolution";
          keyColor = "light_blue";
        }
        {
          type = "Terminal";
          keyColor = "light_green";
        }
        {
          type = "TerminalFont";
          key = "Font";
          keyColor = "light_green";
        }
        {
          type = "CPU";
          temp = true;
          keyColor = "light_red";
          format = "{1} @ {#4;35}{8}{#}";
        }
        {
          type = "processes";
          keyColor = "light_red";
        }
        {
          type = "GPU";
          temp = true;
          keyColor = "light_magenta";
          format = "{2} @ {#4;35}{4}{#}";
        }
        {
          type = "Memory";
          key = "RAM";
          keyColor = "light_yellow";
        }
        {
          type = "Swap";
          keyColor = "light_yellow";
        }
        {
          type = "LocalIP";
          keyColor = "light_cyan";
        }
        {
          type = "Custom";
          format = "└{$1}─────{$1}┘";
        }
      ];
    };
  };
}