{
  description = "hosts flake";

  inputs = {
    nixpkgs.url = "github:nixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixOS/nixpkgs/nixos-24.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";

    nix-darwin  = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixpkgs-darwin, nix-darwin, nix-on-droid, ... }@inputs:
  let
    username = "div";
    system = builtins.currentSystem; # impure
  in
  {
    darwinConfigurations = {
      L1 = let # macOS
          hostname = "L1";
        in nix-darwin.lib.darwinSystem {
          inherit inputs;
          inherit system;
          pkgs = import nixpkgs { inherit system; };
          specialArgs = {
            pkgs-darwin = import nixpkgs-darwin { inherit system; };
            inherit hostname;
            inherit username;
          };

          modules = [
            ./darwin/${hostname}
          ];
        };
    };

    nixOnDroidConfigurations = {
      default = let # Android
          hostname = "M1";
        in nix-on-droid.lib.nixOnDroidConfiguration {
          pkgs = import nixpkgs { inherit system; };

          modules = [
            ./droid/${hostname}
          ];
        };
    };
  };
}