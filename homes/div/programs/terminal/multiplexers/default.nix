{ pkgs, ... }:

{
  imports = [
    ./screen
    ./tmux
  ];

  # Disabled
  programs.zellij = {
    enable = false;
    package = pkgs.zellij;

    enableFishIntegration = false; enableZshIntegration = false; enableBashIntegration = false;
  };
}