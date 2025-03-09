{ pkgs, config, ... }:

{
  home.packages = [ pkgs.weechat ];

  xdg.configFile."weechat" = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ./conf;
    recursive = true;
  };
}