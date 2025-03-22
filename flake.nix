{
  description = "OS-nixCfg flake";
  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      {
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      let
        user = {
          fullname = "Divit Mittal";
          username = "div";
          emails = [
            "64.69.76.69.74.m@gmail.com"
            "mittaldivit@gmail.com"
          ];
        };

        systems = [
          "x86_64-darwin"
          "aarch64-linux"
          "x86_64-linux"
        ];
      in
      {
        _module.args = {
          inherit user;
        };

        imports = [
          ./pre-commit-hooks.nix
          ./home
          ./hosts
        ];

        inherit systems;
        perSystem =
          { pkgs, system, ... }:
          {
            _module.args = {
              pkgs = inputs.nixpkgs.legacyPackages.${system};
            };
            formatter = pkgs.nixfmt-rfc-style;
          };
      }
    );

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

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    easy-hosts.url = "github:tgirlcloud/easy-hosts";

    sops-nix.url = "github:Mic92/sops-nix";

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}