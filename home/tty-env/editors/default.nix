{ pkgs, ... }:

{
  imports = [
    ./vim
    ./nvim
    ./emacs
    ./editorconfig.nix
  ];

  home.shellAliases = {
    ed = "${pkgs.ed}/bin/ed -v -p ':'";
  };
}