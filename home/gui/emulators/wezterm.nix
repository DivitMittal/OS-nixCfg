{
  pkgs,
  hostPlatform,
  inputs,
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
  };

  xdg.configFile."wezterm" = {
    enable = true;
    source = "${inputs.TermEmulator-Cfg}/wezterm";
    recursive = true;
  };

  # Install wezterm terminfo for full feature support
  home.packages = with pkgs; [
    wezterm.terminfo
  ];
}
