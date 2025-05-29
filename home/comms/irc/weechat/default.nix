{
  pkgs,
  config,
  lib,
  ...
}: let
  OS_NIXCFG = let
    temp = builtins.getEnv "OS_NIXCFG"; # impure
  in
    if temp == ""
    then throw "Environment variable $OS_NIXCFG must be set"
    else temp;
  weechatConfSourceDir = "${OS_NIXCFG}/home/comms/irc/weechat/conf";
  weechatConfEntries = builtins.readDir weechatConfSourceDir;
  weechatConfNames = lib.attrsets.attrNames weechatConfEntries;
  dynamicWeechatFiles = lib.attrsets.listToAttrs (
    lib.lists.map (entryName: {
      name = "weechat/${entryName}";
      value = {
        source = config.lib.file.mkOutOfStoreSymlink "${weechatConfSourceDir}/${entryName}"; # impure
      };
    })
    weechatConfNames
  );
in {
  home.packages = lib.attrsets.attrVals ["weechat"] pkgs;

  xdg.configFile =
    dynamicWeechatFiles
    // {
      "weechat/sec.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.age.secrets.weechatSec.path}"; # impure
    };
}
