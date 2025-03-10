{
  description = "hosts flake";

  inputs = {
    nixpkgs.url = "github:nixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs-stable.url = "github:nixOS/nixpkgs/nixos-24.11";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    easy-hosts.url = "github:tgirlcloud/easy-hosts";
  };

  outputs = {self, flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} (_: {
      flake.user = {
        fullname = "Divit Mittal";
        username = "div";
      };

      ## flake modules
      imports = [
        inputs.easy-hosts.flakeModule
        ./droid
      ];

      easy-hosts = {
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

        perClass = class: let inherit(inputs.nixpkgs.lib) optionals; in {
          modules = optionals (class == "darwin") [
            ./darwin/common
          ] ++ optionals (class == "nixos") [
            ./nixOS/common
          ];
        };

        shared = {
          modules = [
            ./common
            inputs.nix-index-database.darwinModules.nix-index { programs.nix-index.enable = false; programs.nix-index-database.comma.enable = true; }
          ];
          specialArgs = {
            user = self.user;
          };
        };
      };

      systems = [
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      perSystem = {pkgs, system, ...}: {
        # _module.args.pkgs = import inputs.nixpkgs { inherit system; };
        formatter = inputs.nixpkgs.legacyPackages.alejandra;
      };
    });
}