{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ rclone ];

  # impure link
  home.file.rclone = {
    enable = false;
    source = config.lib.file.mkOutOfStoreSymlink /. + builtins.toPath "${config.paths.secrets}/rclone/rclone.conf";
    target = "${config.xdg.configHome}/rclone/rclone.conf";
  };
}