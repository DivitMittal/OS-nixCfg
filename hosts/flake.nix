{
  description = "hosts flake";

  inputs = {
    nixpkgs.url = "github:nixOS/nixpkgs/nixpkgs-unstable" ;
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    nix-darwin  = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-darwin, nix-darwin, nix-on-droid, ... }@inputs:
  let
    username = "div";
  in
  {
    darwinConfigurations = {
      L1 = let
          hostname = "L1";
          system = "x86_64-darwin";
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
      M1 = let
        hostname = "M1";
        system = "aarch64-linux";
      in nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs { inherit system; };
        inherit hostname;
        inherit username;

        modules = [
          ./droid/${hostname}
        ];
      };
    };
  };
}