{ pkgs, config, ... }:

{
  # home.packages = builtins.attrValues {
  #   inherit(pkgs)
  #     weechat
  #   ;
  # };
  #
  # xdg.configFile."weechat" = {
  #   source = config.lib.file.mkOutOfStoreSymlink ./conf;
  #   recursive = true;
  # };
}