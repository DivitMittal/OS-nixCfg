{ pkgs, ... }:

{
  imports = [
    ./screen
    ./tmux
  ];

  # Disabled
  programs.zellij = {
    enable = true;
    package = pkgs.zellij;

    enableFishIntegration = false; enableZshIntegration = false; enableBashIntegration = false;
  };
}