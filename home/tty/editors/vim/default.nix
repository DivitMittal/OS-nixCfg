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
}
