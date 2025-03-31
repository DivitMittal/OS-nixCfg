{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim;

    defaultEditor = false;
    extraConfig = builtins.readFile ./vimrc;
  };

  home.shellAliases = {
    ed = "${pkgs.ed}/bin/ed -v -p ':'";
  };
}