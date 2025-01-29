{ config, ... }:

{
  home.file.kanata-tray = {
    enable = true;
    source = ./kanata-tray.toml;
    target = "${config.home.homeDirectory}/Library/Application Support/kanata-tray/kanata-tray.toml";
  };
}