_: {
  topology.self = {
    # name defaults to config.networking.hostName

    hardware.info = "WSL2 Instance - Windows Subsystem for Linux";

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
