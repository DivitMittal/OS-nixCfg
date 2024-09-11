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
      url = "github:nix-community/nix-on-droid/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-darwin, nix-darwin, nix-on-droid, ... }@inputs:
  let
    system  = "x86_64-darwin";
    pkgs = import nixpkgs { inherit system; };
    pkgs-darwin  = import nixpkgs-darwin { inherit system; };
  in
  {
    # nix-darwin
    darwinConfigurations = {
      "div-mbp" = nix-darwin.lib.darwinSystem {
        inherit system;
        inherit inputs;
        inherit pkgs;

        specialArgs = {
          inherit pkgs-darwin;
        };

        modules = [
          ./darwin/div-mbp
        ];
      };
    };

    # nix-on-droid
    nixOnDroidConfigurations = {
      default = nix-on-droid.lib.nixOnDroidConfiguration {
        inherit pkgs;

        modules = [
          ./droid/m1
        ];
      };
    };
  };
}