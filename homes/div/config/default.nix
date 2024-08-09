{ config, ...}:

{
  home.file = {
    # impure symlinks
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

    # pure symlinks
    spicetify = {
      enable = true;
      source = ./spicetify/config-xpui.ini;
      target = "${config.xdg.configHome}/spicetify/config-xpui.ini";
    };
    ideavim = {
      enable = true;
      source = ./ideavim/ideavimrc;
      target = "${config.xdg.configHome}/ideavim/ideavimrc";
    };
    weechat = {
      enable = true;
      source = ./weechat;
      target = "${config.xdg.configHome}/weechat";
      recursive = true;
    };
    ov = {
      enable = true;
      source = ./ov/config.yaml;
      target = "${config.xdg.configHome}/ov/config.yaml";
    };

    # disabled
    hammerspoon = {
      enable = false;
      source = ./hammerspoon/init.lua;
      target = "${config.xdg.configHome}/hammerspoon/init.lua";
    };
  };
}