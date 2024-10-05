{ pkgs, ... } :

let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [ "CascadiaCode" ];
  };
in
{
  imports = [
    ./../common
    ./ssh.nix
  ];

  terminal = {
    colors = {
      background = "#000000";
      foreground = "#FFFFFF";
      cursor = "#FF0000";
    };

    font =  "${nerdfonts}/share/fonts/truetype/NerdFonts/CaskaydiaCoveNerdFontMono-Regular.ttf";
  };
}