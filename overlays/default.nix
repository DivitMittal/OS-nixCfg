{inputs, ...}: let
  additions = self: super: (
    super.lib.packagesFromDirectoryRecursive {
      callPackage = super.lib.customisation.callPackageWith self;
      directory = ../pkgs;
    }
  );

  master-pkgs = _: _: {
    master = builtins.import inputs.nixpkgs-master {
      config = {
        allowUnfree = true;
        allowBroken = false;
        allowUnsupportedSystem = false;
        allowInsecure = true;
      };
    };
  };

  darwin-pkgs = _: _: {
    darwinStable = builtins.import inputs.nixpkgs-darwin {
      config = {
        allowUnfree = true;
        allowBroken = false;
        allowUnsupportedSystem = false;
        allowInsecure = true;
      };
    };
  };
in {
  default = self: super:
    super.lib.attrsets.mergeAttrsList [
      (additions self super)
      (master-pkgs self super)
      (darwin-pkgs self super)
    ];
}
