{ inputs, ... }:

{
  flake.nixOnDroidConfigurations = {
    default = let # Android
        hostname = "M1";
        system = "aarch64-linux";
      in inputs.nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import inputs.nixpkgs { inherit system; };

        modules = [
          ./../common
          ./common
          ./${hostname}
        ];
      };
  };
}