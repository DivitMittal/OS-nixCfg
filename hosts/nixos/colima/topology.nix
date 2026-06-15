_: {
  topology.self = {
    hardware.info = "NixOS VM - Colima/Lima (x86_64) on L1 (macOS)";

    interfaces = {
      eth0 = {
        network = "colima-x86";
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
