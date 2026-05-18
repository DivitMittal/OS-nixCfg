_: {
  topology.self = {
    hardware.info = "NixOS on Apple T2 MacBook";

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
