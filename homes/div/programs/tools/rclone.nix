{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ rclone ];

  # impure
  home.file.rclone = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink (/. + "${config.paths.secrets}/rclone.conf");
    target = "${config.xdg.configHome}/rclone/rclone.conf";
  };
}