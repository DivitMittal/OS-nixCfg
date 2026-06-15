_: {
  topology.self = {
    hardware.info = "NixOS Asahi (aarch64) - dual-boot with ASL1 (macOS) on Apple Silicon";

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
