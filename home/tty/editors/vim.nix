{
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim;

    defaultEditor = false;
    extraConfig = lib.strings.readFile (inputs.Vim-Cfg + "/vim/vimrc");
  };
}
