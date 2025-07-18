{
  inputs,
  self,
  ...
}: let
  nixpkgs-overlay = builtins.import ./nixpkgs.nix {inherit inputs;};
in {
  flake.overlays.custom = self: super: {
    customDarwin = super.lib.packagesFromDirectoryRecursive {
      callPackage = super.lib.customisation.callPackageWith self;
      directory = ../pkgs/darwin;
    };
    customPypi = super.lib.packagesFromDirectoryRecursive {
      inherit (super.python3Packages) callPackage;
      directory = ../pkgs/pypi;
    };
  };

  flake.overlays = {
    default = self.outputs.overlays.custom;
    inherit (nixpkgs-overlay) pkgs-master pkgs-darwin pkgs-nixos;
  };
}
