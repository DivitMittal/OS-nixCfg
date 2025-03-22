{ config, user, ... }:

{
  wsl = {
    enable = true;

    defaultUser = "${user.username}";

    useWindowsDriver = true;

    interop.includePath = true;
    startMenuLaunchers = false;

    wslConf = {
      automount = {
        enabled = true;
        root = "/mnt";
      };
      boot.systemd = true;
      user.default = "${config.wsl.defaultUser}";
    };

    system.stateVersion = "24.05";
  };
}