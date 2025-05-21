{inputs, ...}: let
  config = {
    allowUnfree = true;
    allowBroken = false;
    allowUnsupportedSystem = false;
    allowInsecure = true;
  };

  additions = self: super: (
    super.lib.packagesFromDirectoryRecursive {
      callPackage = super.lib.customisation.callPackageWith self;
      directory = ../pkgs;
    }
  );

  master-pkgs = _: _: {
    master = builtins.import inputs.nixpkgs-master {inherit config;};
  };

  darwin-pkgs = _: _: {
    darwinStable = builtins.import inputs.nixpkgs-darwin {inherit config;};
  };

  nixos-pkgs = _: _: {
    nixosStable = builtins.import inputs.nixpkgs-nixos {inherit config;};
  };
in {
  default = self: super:
    super.lib.attrsets.mergeAttrsList [
      (additions self super)
      (master-pkgs self super)
    ];
  inherit darwin-pkgs;
  inherit nixos-pkgs;
}