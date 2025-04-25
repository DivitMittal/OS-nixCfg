{pkgs, ...}: {
  home.packages = [pkgs.brewCasks.raycast];

  xdg.configFile."raycast/scripts" = {
    enable = true;
    source = ./scripts;
    recursive = true;
  };
}
