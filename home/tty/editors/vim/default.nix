{
  pkgs,
  lib,
  ...
}: {
  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim;

    defaultEditor = false;
    extraConfig = lib.strings.readFile ./vimrc;
  };

  home.shellAliases = {
    ed = "${pkgs.ed}/bin/ed -v -p ':'";
  };
}
