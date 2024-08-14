{ config, pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./zsh.nix
    ./bash.nix
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];
}