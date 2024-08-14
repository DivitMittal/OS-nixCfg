{ config, ... }:

{
  home.file = {
    aerc = {
      enable = true;
      source = /. + builtins.toPath "${config.home.homeDirectory}/OS-nixCfg/secrets/email/aerc/accounts.conf";
      target = "${config.xdg.configHome}/aerc/accounts.conf";
    };

    rclone = {
      enable = true;
      source = /. + builtins.toPath "${config.home.homeDirectory}/OS-nixCfg/secrets/rclone/rclone.conf";
      target = "${config.xdg.configHome}/rclone/rclone.conf";
    };
  };
}