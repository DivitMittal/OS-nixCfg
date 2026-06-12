_: {
  topology.self = {
    hardware.info = "NixOS VM - Colima/Lima on L1 (macOS)";

    interfaces = {
      eth0 = {
        network = "colima";
        type = "virtual";
        virtual = true;
        physicalConnections = [
          {
            node = "L1";
            interface = "col0";
          }
        ];
      };
    };
  };
}
