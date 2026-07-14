_: {
  topology.self = {
    hardware.info = "KVM VPS2 (x86_64-linux) - Germany, 1 vCPU, 6 GiB RAM, ~200ms RTT, server workloads";
    interfaces.eth0 = {
      network = "internet";
      type = "virtual";
      virtual = true;
    };
  };
}
