{
  inputs,
  self,
  ...
}: {
  imports = [
    inputs.nix-topology.flakeModule
  ];

  perSystem = _: {
    topology = {
      modules = [
        {
          networks.home = {
            name = "Home Network";
            cidrv4 = "192.168.1.0/24";
          };

          networks.wsl = {
            name = "WSL Network";
            cidrv4 = "172.16.0.0/12";
          };

          networks.mobile = {
            name = "Mobile Network";
            cidrv4 = "10.0.0.0/8";
          };

          networks.internet = {
            name = "Internet";
            cidrv4 = "0.0.0.0/0";
          };

          # Lima/Colima virtual bridge networks (one per host Mac)
          networks.colima-x86 = {
            name = "Colima x86_64 Network";
            cidrv4 = "192.168.5.0/24";
          };

          networks.colima-arm = {
            name = "Colima ARM Network";
            cidrv4 = "192.168.106.0/24";
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

          # x86_64 MacBook — triple-boot: macOS (L1 / nix-darwin) | NixOS T2 | Windows 11
          nodes.L1 = {
            name = "L1";
            deviceType = "device";
            hardware.info = "macOS nix-darwin (x86_64) - triple-boot with T2 NixOS & Windows 11";
            interfaces.en0 = {
              network = "home";
              type = "wifi";
              physicalConnections = [
                {
                  node = "router";
                  interface = "wlan";
                }
              ];
            };
            # Virtual bridge for the Colima x86_64 VM
            interfaces.col0 = {
              network = "colima-x86";
              type = "virtual";
              virtual = true;
            };
          };

          # Apple Silicon MacBook — dual-boot: macOS (AS / nix-darwin) | NixOS Asahi
          nodes.ASL1 = {
            name = "ASL1";
            deviceType = "device";
            hardware.info = "macOS nix-darwin (aarch64) - dual-boot with Asahi NixOS";
            interfaces.en0 = {
              network = "home";
              type = "wifi";
              physicalConnections = [
                {
                  node = "router";
                  interface = "wlan";
                }
              ];
            };
            # Virtual bridge for the Colima ARM VM
            interfaces.col0 = {
              network = "colima-arm";
              type = "virtual";
              virtual = true;
            };
          };

          # Windows 11 boot on the x86_64 MacBook (triple-boot partner of L1 & T2)
          # Managed by https://github.com/DivitMittal/playbooks-4-windows (Ansible IaC)
          nodes.windows-host = {
            name = "Windows Host";
            deviceType = "device";
            hardware.info = "Windows 11 (Ansible IaC) - triple-boot with L1 (macOS) & T2 (NixOS) on same x86_64 hardware";
            interfaces.wlan0 = {
              network = "home";
              type = "wifi";
              physicalConnections = [
                {
                  node = "router";
                  interface = "wlan";
                }
              ];
            };
            interfaces.wsl0 = {
              network = "wsl";
              type = "virtual";
              virtual = true;
            };
          };

          nodes.M1 = {
            name = "M1";
            deviceType = "device";
            hardware.info = "Android - nix-on-droid (aarch64 MediaTek)";
            interfaces.wlan0 = {
              network = "home";
              type = "wifi";
              physicalConnections = [
                {
                  node = "router";
                  interface = "wlan";
                }
              ];
            };
            interfaces.mobile0 = {
              network = "mobile";
              type = "mobile";
            };
          };
        }
        # Pass the nixosConfigurations so topology can discover them
        {
          inherit (self) nixosConfigurations;
        }
      ];
    };
  };
}
