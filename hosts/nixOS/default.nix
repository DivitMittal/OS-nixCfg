{ pkgs, ... }:

{
  flake.nixosConfigurations = pkgs.lib.nixosSystem {
  };
}