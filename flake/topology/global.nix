_: {
  networks.home = {
    name = "Home Network";
    cidrv4 = "192.168.1.0/24";
  };

  networks.wsl = {
    name = "WSL Network";
    cidrv4 = "172.16.0.0/12";
  };

  networks.internet = {
    name = "Internet";
    cidrv4 = "0.0.0.0/0";
  };

  nodes.router = {
    name = "Home Router";
    deviceType = "router";
    hardware.info = "Consumer Router";
    interfaces.wan = {
      network = "internet";
      type = "wan";
    };
    interfaces.lan = {
      network = "home";
      type = "ethernet";
    };
    interfaces.wlan = {
      network = "home";
      type = "wifi";
    };
  };

  # macOS system (nix-darwin) - defined as non-NixOS node
  nodes.L1 = {
    name = "L1";
    deviceType = "device";
    hardware.info = "macOS - nix-darwin (x86_64)";
    interfaces.en0 = {
      network = "home";
      type = "wifi";
    };
  };
}
