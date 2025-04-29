{pkgs, ...}: {
  programs.firefox.nativeMessagingHosts = [pkgs.tridactyl-native];

  xdg.configFile."tridactyl" = {
    source = ./config;
    recursive = true;
  };
}
