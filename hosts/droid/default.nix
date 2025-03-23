{ self, inputs, user,... }:

let
  nixOnDroidGenerator = additionalModules:
    inputs.nix-on-droid.lib.nixOnDroidConfiguration rec {
      system = "aarch64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system}; # memoized
      home-manager-path = inputs.home-manager.outPath;
      extraSpecialArgs = {
        inherit inputs self user system;
      };
      modules = [
        ./common
      ] ++ additionalModules;
    };
in
{
  flake.nixOnDroidConfigurations = {
    M1 = nixOnDroidGenerator [
      ./M1
    ];
  };
}