{ inputs, ... }:

let
  nixDroidGenerator = system: additionalModules:
    inputs.nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system}; # memoized
      modules = [
      ./common
      ] ++ additionalModules;
    };
in
{
  flake.nixOnDroidConfigurations = {
    default = nixDroidGenerator "aarch64-linux" [
      ./M1
    ];
  };
}