{
  pkgs,
  config,
  lib,
  self,
  ...
}: let
  weechatConfSourceDir = "${self}/home/comms/irc/weechat/conf";
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
      "weechat/sec.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.age.secrets."weechat/sec.conf".path}"; # impure
    };
}
