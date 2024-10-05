{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ spicetify-cli ];

  home.file.spicetifyCfg = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink (/. + "${config.paths.homeCfg}/programs/utils/spicetify/config-xpui.ini");
    target = "${config.xdg.configHome}/spicetify/config-xpui.ini";
  };
}