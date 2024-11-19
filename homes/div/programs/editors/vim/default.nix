{ pkgs, pkgs-darwin, ... }:

{
  programs.vim = {
    enable = true;
    packageConfigurable = if pkgs.stdenvNoCC.hostPlatform.isDarwin then pkgs-darwin.vim else pkgs.vim;

    defaultEditor = false;
    extraConfig = builtins.readFile ./vimrc;
  };
}