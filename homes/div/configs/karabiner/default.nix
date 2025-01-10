{ config, ... }:

{
  home.file.assets = {
    enable = true;
    source = ./assets;
    target = "${config.xdg.configHome}/karabiner/assets";
    recursive = true;
  };

  home.file.settings = {
    enable = true;
    source = ./karabiner.json;
    target = "${config.xdg.configHome}/karabiner/karabiner.json";
  };
}