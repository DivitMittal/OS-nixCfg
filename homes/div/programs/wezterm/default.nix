{ pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    package = pkgs.hello; # Installed via Homebrew instead

    enableBashIntegration = false; enableZshIntegration = false;

    extraConfig = builtins.readFile ./wezterm.lua;
  };
}