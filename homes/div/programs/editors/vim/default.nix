{ pkgs, pkgs-darwin, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  programs.vim = {
    enable = true;
    packageConfigurable = if isDarwin then pkgs-darwin.vim else pkgs.vim;

    defaultEditor = false;
    extraConfig = builtins.readFile ./vimrc;
  };
}