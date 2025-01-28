{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ weechat ];

  home.file.weechat = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ./conf;
    target = "${config.xdg.configHome}/weechat";
    recursive = true;
  };
}