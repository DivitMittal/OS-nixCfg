{ config, ... }:

{
  wsl = {
    enable = true;

    defaultUser = "${config.hostSpec.username}";

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