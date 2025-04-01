{
  description = "OS-nixCfg flake";
  outputs = { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      {config, ...}: let
        mkHost = {
          hostName,
          system,
          class,
          additionalModules ? [ ],
          extraSpecialArgs ? { },
        }: let
          configGenerator = {
            darwin = inputs.nix-darwin.lib.darwinSystem;
            nixos = inputs.nixpkgs.lib.nixosSystem;
            droid = inputs.nix-on-droid.lib.nixOnDroidConfiguration;
            home = inputs.home-manager.lib.homeManagerConfiguration;
          };

          systemFunc = configGenerator.${class};
          #lib = inputs.nixpkgs.lib; # unextended
          # ========== Extend lib with lib.custom ==========
          # NOTE: This approach allows lib.custom to propagate into hm
          # see: https://github.com/nix-community/home-manager/pull/3454
          lib = inputs.nixpkgs.lib.extend (_: _: {custom = import ./lib {inherit (inputs.nixpkgs) lib;};} // inputs.home-manager.lib); # extended
          #pkgs = import inputs.nixpkgs { inherit system; overlays = [ ]; }; # not-memoized
          pkgs = inputs.nixpkgs.legacyPackages.${system}; # memoized
          specialArgs = {
              inherit self inputs;
              inherit (pkgs.stdenvNoCC) hostPlatform;
            } // extraSpecialArgs;
          modules =
            [
              ./nix.nix
              ./modules/common
              {
                hostSpec = {
                  inherit (inputs.OS-nixCfg-secrets.user) username userFullName handle email;
                  inherit hostName;
                };
              }
            ]
            ++ lib.optionals (class == "darwin" || class == "nixos") [
              ./hosts/common
              ./hosts/${class}/common
              ./hosts/${class}/${hostName}
              ./modules/hosts/${class}
            ]
            ++ lib.optionals (class == "droid") [
              ./hosts/${class}/common
            ]
            ++ lib.optionals (class == "home") [
              ./modules/home
              ./home/common
              ./home/tty
              inputs.nix-index-database.hmModules.nix-index { programs.nix-index.enable = true; programs.nix-index-database.comma.enable = true; }
              inputs.ragenix.homeManagerModules.default ./home/age.nix
              inputs.kanata-tray.homeManagerModules.kanata-tray
            ];
        in
          systemFunc (
            {
              inherit pkgs;
              inherit lib;
              modules = modules ++ additionalModules;
            }
            // (lib.attrsets.optionalAttrs (class == "darwin" || class == "nixos") { inherit specialArgs; })
            // (lib.attrsets.optionalAttrs (class == "droid") {
              extraSpecialArgs = specialArgs;
              home-manager-path = inputs.home-manager.outPath;
            })
            // (lib.attrsets.optionalAttrs (class == "home") { extraSpecialArgs = specialArgs; })
          );
      in {
        _module.args = {
          inherit self;
          inherit mkHost;
        };

        imports = [
          ./devShell.nix
          ./checks.nix
          ./home
          ./hosts
        ];

        systems = import inputs.systems;

        perSystem = { pkgs, ... }: {
          ## Causes infinite-recursion
          # _module.args = {
          #   inherit pkgs;
          # };
          formatter = pkgs.alejandra;
        };
      }
    );

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs-stable.url = "github:nixOS/nixpkgs/nixos-24.11";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";

    systems = {
      url = "github:nix-systems/default";
      inputs = { };
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        darwin.follows = "nix-darwin";
        systems.follows = "systems";
      };
    };

    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.agenix.follows = "agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    OS-nixCfg-secrets = {
      url = "git+ssh://git@github.com/DivitMittal/OS-nixCfg-secrets.git?ref=master";
      # url = "path:/Users/div/OS-nixCfg-secrets";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        devshell.follows = "devshell";
        agenix.follows = "agenix";
        ragenix.follows = "ragenix";
      };
    };

    kanata-tray = {
      url = "github:DivitMittal/kanata-tray/flake-darwin-support";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}