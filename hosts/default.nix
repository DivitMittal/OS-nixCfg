{ user, inputs, self, pkgs, ... }:

{
  imports = [
    inputs.easy-hosts.flakeModule
    ./droid
  ];

  # darwin & nixos hosts
  easy-hosts = {
    shared = {
      modules = [
        ./common
        (self + /nix.nix)
      ];
      specialArgs = {
        inherit user;
        inherit(pkgs.stdenvNoCC) hostPlatform;
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
        class = "darwin";
        arch = "x86_64";
        deployable = true;
        path = ./darwin/L1;
        # specialArgs = {
        #   hostname = "L1";
        # };
      };

      L2 = {
        class = "nixos";
        arch = "x86_64";
        deployable = true;
        path = ./nixOS/L2;
        modules = [
          /etc/nixos/hardware-configuration.nix # impure
        ];
      };

      WSL = {
        class = "nixos";
        arch = "x86_64";
        deployable = true;
        path = ./nixOS/WSL;
        modules = [
          inputs.nixos-wsl.nixosModules.default
        ];
      };
    };
  };
}