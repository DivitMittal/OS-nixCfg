{ lib, ... }:

{
  imports = lib.custom.scanPaths ./.;

  programs.zsh.profileExtra = "unset MAILCHECK";
  programs.bash.profileExtra = "unset MAILCHECK";
}