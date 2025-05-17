{inputs, ...}: let
  additions = final: prev: (
    prev.lib.packagesFromDirectoryRecursive {
      callPackage = prev.lib.customisation.callPackageWith final;
      directory = ../pkgs;
    }
  );

  master-pkgs = _final: _prev: {
    master = import inputs.pkgs-master {
      config = {
        allowUnfree = true;
        allowBroken = false;
        allowUnsupportedSystem = false;
        allowInsecure = true;
      };
    };
  };
in {
  default = final: prev:
    prev.lib.attrsets.mergeAttrsList [
      (additions final prev)
      (master-pkgs final prev)
    ];
}
