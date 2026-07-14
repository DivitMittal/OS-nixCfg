_: {
  topology.self = {
    hardware.info = "KVM VPS1 (x86_64-linux) - Mumbai, 3 vCPU, 5 GiB RAM, ~30ms RTT, interactive workloads";
    interfaces.eth0 = {
      network = "internet";
      type = "virtual";
      virtual = true;
    };
  };
}
