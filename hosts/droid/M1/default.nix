{ pkgs, config, ... } :

{
  imports = [
    ./../common
  ];

  user.shell = "${pkgs.zsh}/bin/zsh";

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
    extraSpecialArgs = {
      repo = "${config.user.home}/OS-nixCfg";
    };
    backupFileExtension = ".bak";
  };
}
