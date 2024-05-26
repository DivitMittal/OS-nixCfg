{
  description = "hosts flake";

  inputs = {
    nixpkgs.url = "github:nixOS/nixpkgs/nixpkgs-unstable" ;

    nix-darwin  = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, nix-on-droid, ... }@inputs:

  {
    darwinConfigurations = {
      "div-mbp" = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [ ./darwin/div-mbp ];
        specialArgs = { inherit inputs; };
      };
    };
    darwinPackages = self.darwinConfigurations."div-mbp".pkgs; # Expose the package set, including overlays, for convenience.

    nixOnDroidConfigurations = {
      default = nix-on-droid.lib.nixOnDroidConfiguration {
          modules = [ ./droid/m1 ];
      };
    };
  };
}