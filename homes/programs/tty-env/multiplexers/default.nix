{ pkgs, ... }:

{
  imports = [
    ./screen
    ./tmux
    ./zellij.nix
  ];
}