{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ rclone ];

  # impure link
  home.file.rclone = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink /. + builtins.toPath "${config.home.homeDirectory}/OS-nixCfg/secrets/rclone/rclone.conf";
    target = "${config.xdg.configHome}/rclone/rclone.conf";
  };
}