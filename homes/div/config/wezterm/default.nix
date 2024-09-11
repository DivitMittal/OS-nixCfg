{ pkgs, pkgs-darwin, ... }:

{
  programs.wezterm = {
    enable = true;
    package = pkgs-darwin.wezterm; # Installed via Homebrew instead

    enableBashIntegration = false; enableZshIntegration = false;

    extraConfig = builtins.readFile ./wezterm.lua;
  };
}