{
  pkgs,
  hostPlatform,
  ...
}: let
  raycast =
    if hostPlatform.isx86_64
    then (pkgs.brewCasks.raycast.override {variation = "sequoia";})
    else pkgs.brewCasks.raycast;
in {
  home.packages = [raycast];

  xdg.configFile."raycast/scripts" = {
    enable = true;
    source = ./scripts;
    recursive = true;
  };
}
