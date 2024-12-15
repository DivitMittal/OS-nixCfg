{ pkgs, ... } :

{
  imports = [
    ./../common
  ];

  user.shell = "${pkgs.fish}/bin/fish";

  terminal = {
    colors = {
      background = "#000000";
      foreground = "#FFFFFF";
      cursor = "#FF0000";
    };
    font =  "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/CaskaydiaCoveNerdFontMono-Regular.ttf";
  };

  home-manager = {
    config = import ./home.nix;
    backupFileExtension = ".bak";
  };
}