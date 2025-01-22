{ pkgs, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  programs.wezterm = {
    enable = true;
    enableBashIntegration = false; enableZshIntegration = false;
    package = if isDarwin then pkgs.hello else pkgs.wezterm;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}