{
  pkgs,
  hostPlatform,
  lib,
  ...
}: {
  programs.wezterm = {
    enable = true;
    package =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.wezterm
      else pkgs.wezterm;

    enableBashIntegration = false;
    enableZshIntegration = false;
    extraConfig = lib.strings.readFile ./wezterm.lua;
  };
}
