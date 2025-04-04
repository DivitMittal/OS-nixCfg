{
  pkgs,
  config,
  lib,
  ...
}: let
  OS_NIXCFG = builtins.getEnv "OS_NIXCFG"; # impure
  weechatConfSourceDir = "${OS_NIXCFG}/home/comms/irc/weechat/conf";
  weechatConfEntries = builtins.readDir weechatConfSourceDir;
  weechatConfNames = lib.attrNames weechatConfEntries;
  dynamicWeechatFiles = lib.listToAttrs (
    lib.map (entryName: {
      name = "weechat/${entryName}";
      value = {
        source = config.lib.file.mkOutOfStoreSymlink "${weechatConfSourceDir}/${entryName}";
      };
    })
    weechatConfNames
  );
in {
  home.packages = builtins.attrValues {
    inherit (pkgs)
      weechat;
  };

  xdg.configFile = dynamicWeechatFiles // {
    "weechat/sec.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.age.secrets.weechatSec.path}";
  };
}