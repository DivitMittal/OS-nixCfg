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
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} (_: {
      systems = ["x86_64-darwin" "aarch64-linux" "x86_64-linux"];

      flake.user = {
        fullname = "Divit Mittal";
        username = "div";
      };

      perSystem = {pkgs, ...}: {
        formatter = inputs.nixpkgs.legacyPackages.alejandra;
      };

      imports = [
        ./droid
        ./nixOS
        ./darwin
      ];
    });
}