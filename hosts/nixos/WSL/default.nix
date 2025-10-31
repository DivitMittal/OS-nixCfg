{config, ...}: {
  networking.nameservers = [];
  wsl = {
    enable = true;

    defaultUser = "${config.hostSpec.username}";

    useWindowsDriver = true;

    interop = {
      includePath = true;
      register = true; # Required when using binfmt registrations to preserve .exe compatibility
    };
    startMenuLaunchers = false;

    wslConf = {
      automount = {
        enabled = true;
        root = "/mnt";
      };
      boot.systemd = true;
      user.default = "${config.wsl.defaultUser}";
    };
  };
  system.stateVersion = "24.05";
}
