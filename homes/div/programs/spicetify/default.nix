{ pkgs, config, ... }:

{

  home.packages = with pkgs; [ spicetify-cli ];

  home.file.spicetify_config = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink /. + builtins.toPath "${./config-xpui.ini}";
    target = "${config.xdg.configHome}/spicetify/config-xpui.ini";
  };
}