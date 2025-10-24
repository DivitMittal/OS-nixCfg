_: {
  topology.self = {
    # name defaults to config.networking.hostName

    hardware.info = "NixOS Desktop - Physical Hardware";

    interfaces = {
      eth0 = {
        network = "home";
        type = "ethernet";
        physicalConnections = [
          {
            node = "router";
            interface = "lan";
          }
        ];
      };
    };
  };
}
