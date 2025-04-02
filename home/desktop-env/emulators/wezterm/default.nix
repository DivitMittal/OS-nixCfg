{ pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    enableBashIntegration = false; enableZshIntegration = false;
    package = pkgs.wezterm;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}