{ config, ...}:

{
  imports = [
    ./screen
    ./nvim
  ];

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
      source = ./spicetify/config-xpui.ini;
      target = "${config.xdg.configHome}/spicetify/config-xpui.ini";
    };
    hammerspoon = {
      enable = false;
      source = ./hammerspoon/init.lua;
      target = "${config.xdg.configHome}/hammerspoon/init.lua";
    };
    ideavim = {
      source = ./ideavim/ideavimrc;
      target = "${config.xdg.configHome}/ideavim/ideavimrc";
    };
    doomEmacs = {
      source = ./doom;
      target = "${config.xdg.configHome}/doom";
      recursive = true;
    };
    tmux = {
      source = ./tmux;
      target = "${config.xdg.configHome}/tmux";
      recursive = true;
    };
    weechat = {
      source = ./weechat;
      target = "${config.xdg.configHome}/weechat";
      recursive = true;
    };
    tridactyl = {
      source = ./tridactyl;
      target = "${config.xdg.configHome}/tridactyl";
      recursive = true;
    };
    ov = {
      source = ./ov/config.yaml;
      target = "${config.xdg.configHome}/ov/config.yaml";
    };
  };
}