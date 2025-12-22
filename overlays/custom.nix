_: {
  custom = self: super: {
    customDarwin = super.lib.packagesFromDirectoryRecursive {
      callPackage = super.lib.customisation.callPackageWith self;
      directory = ../pkgs/darwin;
    };
    customPypi = super.lib.packagesFromDirectoryRecursive {
      inherit (super.python3Packages) callPackage;
      directory = ../pkgs/pypi;
    };
    custom = super.lib.packagesFromDirectoryRecursive {
      callPackage = super.lib.customisation.callPackageWith self;
      directory = ../pkgs/custom;
    };
  };
}
