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

  programs.direnv = {
    enable = true;
    package = pkgs.direnv;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };
}