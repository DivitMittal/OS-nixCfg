{ pkgs, config, lib, ... }:

let
  enable = false;
in
{
  home.packages = lib.optionals (enable == true) [ pkgs.weechat ];

  xdg.configFile."weechat" = {
    inherit enable;
    source = config.lib.file.mkOutOfStoreSymlink ./conf;
    recursive = true;
  };
}