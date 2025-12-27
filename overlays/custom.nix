_: {
  # Custom overlay that provides additional packages from local directories
  #
  # Performance note: packagesFromDirectoryRecursive is efficient as it:
  # 1. Lazily evaluates packages (only builds what's actually used)
  # 2. Uses Nix's evaluation cache for directory structure scans
  # 3. Properly handles dependencies between packages
  #
  # The packages are organized by platform/type:
  # - customDarwin: macOS-specific packages
  # - customPypi: Python packages not in nixpkgs
  # - custom: General custom packages for all platforms
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
