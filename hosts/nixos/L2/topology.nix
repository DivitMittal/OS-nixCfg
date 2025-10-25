_: {
  topology.self = {
    # name defaults to config.networking.hostName

    hardware.info = "NixOS Desktop - Physical Hardware";

    interfaces = {
      wlan0 = {
        network = "home";
        type = "wireless";
        physicalConnections = [
          {
            node = "router";
            interface = "wlan";
          }
        ];
      };
    };
  };
}
