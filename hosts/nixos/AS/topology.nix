_: {
  topology.self = {
    hardware.info = "NixOS on Apple Silicon (Asahi Linux)";

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
