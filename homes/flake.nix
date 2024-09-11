{
  description = "home-manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-darwin, home-manager, ... }@inputs:
  let
    system = builtins.currentSystem;
    pkgs = import nixpkgs { inherit system; };
    pkgs-darwin = import nixpkgs-darwin { inherit system; };
  in
  {
    homeConfigurations =  {
      "div" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit pkgs-darwin;
        };

        modules = [
          ./div
        ];
      };
    };
  };
}