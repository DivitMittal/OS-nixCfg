{ config, pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./zsh.nix
    ./bash.nix
    ./extra.nix
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];
}