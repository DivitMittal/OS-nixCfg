{ user, inputs, ... }:

{
  imports = [
    inputs.easy-hosts.flakeModule
    ./droid
  ];

  easy-hosts = {
    shared = {
      modules = [
        ./common
      ];
      specialArgs = {
        inherit user;
      };
    };

    perClass = class: let inherit(inputs.nixpkgs.lib) optionals; in {
      modules = optionals (class == "darwin") [
        ./darwin/common
      ] ++ optionals (class == "nixos") [
        ./nixOS/common
      ];
    };

    hosts = {
      L1 = {
        arch = "x86_64";
        class = "darwin";
        deployable = true;
        path = ./darwin/L1;
        specialArgs = {
          hostname = "L1";
        };
      };

      L2 = {
        arch = "x86_64";
        class = "nixos";
        deployable = true;
        path = ./nixOS/L2;
        modules = [
          /etc/nixos/hardware-configuration.nix # impure
        ];
      };

      WSL = {
        arch = "x86_64";
        class = "nixos";
        deployable = true;
        path = ./nixOS/WSL;
        modules = [
          inputs.nixos-wsl.nixosModules.default
        ];
      };
    };
  };
}