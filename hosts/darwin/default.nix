{ inputs, ... }:

{
  flake.darwinConfigurations = {
    L1 = let # macOS
        hostname = "L1";
        system = "x86_64-darwin";
      in inputs.nix-darwin.lib.darwinSystem {
        inherit inputs;
        inherit system;
        pkgs = import inputs.nixpkgs { inherit system; };
        specialArgs = {
          username = "div";
          inherit hostname;
          # pkgs-darwin = import inputs.nixpkgs-darwin { inherit system; };
        };

        modules = [
          ./../common # TODO: Migrate to a flake helper (flake-utils, flake-parts, ezConfig)
          ./common
          ./${hostname}
          inputs.nix-index-database.darwinModules.nix-index { programs.nix-index.enable = false; programs.nix-index-database.comma.enable = true; }
        ];
      };
  };
}