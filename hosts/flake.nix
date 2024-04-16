{
  description = "hosts flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin  = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, ... }:
  {
    darwinConfigurations = {
      "div-mbp" = nix-darwin.lib.darwinSystem {
        system  = "x86_64-darwin";
        modules = [ ./darwin/div-mbp ];
        specialArgs = {inherit inputs;};
      };
    };

    darwinPackages = self.darwinConfigurations."div-mbp".pkgs; # Expose the package set, including overlays, for convenience.
  };
}