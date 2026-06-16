_: {
  topology.self = {
    # name defaults to config.networking.hostName

    hardware.info = "WSL2 NixOS - home-manager syncs TTY dotfiles (starship, fastfetch, git attrs) to Windows via /mnt/c/";

    interfaces = {
      eth0 = {
        network = "wsl";
        type = "virtual";
        virtual = true;
        physicalConnections = [
          {
            node = "windows-host";
            interface = "wsl0";
          }
        ];
      };
    };
  };
}
