{ inputs, ... }:

{
  flake.nixOnDroidConfigurations = {
    default = let
        system = "aarch64-linux";
      in inputs.nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import inputs.nixpkgs { inherit system; };

        modules = [
          ./../common
          ./common
          ./M1
          inputs.nix-index-database.darwinModules.nix-index { programs.nix-index.enable = false; programs.nix-index-database.comma.enable = true; }
        ];
      };
  };
}