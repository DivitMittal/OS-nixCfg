{
  description = "hosts flake";

  inputs = {
    nixpkgs.url = "github:nixOS/nixpkgs/nixpkgs-unstable" ;

    nix-darwin  = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, nixpkgs, ... }@inputs:

    let
      system = "x86_64-darwin";
    in
    {
      darwinConfigurations = {
        "div-mbp" = nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [ ./darwin/div-mbp ];
          specialArgs = { inherit inputs; };
        };
      };

      darwinPackages = self.darwinConfigurations."div-mbp".pkgs; # Expose the package set, including overlays, for convenience.
    };
}