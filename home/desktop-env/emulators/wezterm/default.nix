{ pkgs, hostPlatform, ... }:

{
  programs.wezterm = {
    enable = true;
    enableBashIntegration = false; enableZshIntegration = false;
    package = (if hostPlatform.isDarwin then pkgs.hello else pkgs.wezterm); # homebrew
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}