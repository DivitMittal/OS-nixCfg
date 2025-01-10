{ config, ... }:

{
  home.file.raycast = {
    enable = true;
    source = ./scripts;
    target = "${config.xdg.configHome}/raycast/scripts";
    recursive = true;
  };
}