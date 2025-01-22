{ pkgs, ... }:

{
  imports = [
    ./firefox
    ./tui.nix
  ];
}