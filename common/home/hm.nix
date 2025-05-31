{
  config,
  lib,
  ...
}: {
  programs.home-manager.enable = true; # home-manager standalone

  home = {
    username = lib.mkDefault config.hostSpec.username;
    homeDirectory = lib.mkDefault config.hostSpec.home;
    preferXdgDirectories = true;
    enableNixpkgsReleaseCheck = true;
    language.base = "en_US.UTF-8";
    stateVersion = lib.mkDefault "25.05";
  };

  ## home-manager manual
  manual = {
    html.enable = true;
    manpages.enable = true;
    json.enable = false;
  };

  xdg.enable = true;
  news.display = "show";
}
