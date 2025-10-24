_: {
  topology.self = {
    # name defaults to config.networking.hostName

    hardware.info = "WSL2 Instance - Windows Subsystem for Linux";

    interfaces = {
      eth0 = {
        network = "wsl";
        type = "virtual";
        virtual = true;
      };
    };

    services = {
      ssh = {
        name = "SSH Server";
        port = 22;
      };
    };
  };
}
