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
  # - custom: General custom packages for all platforms
  custom = self: super: let
    sources = super.callPackage ../pkgs/_sources/generated.nix {};
  in {
    customDarwin = super.lib.packagesFromDirectoryRecursive {
      callPackage = super.lib.customisation.callPackageWith (self // {inherit sources;});
      directory = ../pkgs/darwin;
    };
    custom = super.lib.packagesFromDirectoryRecursive {
      callPackage = super.lib.customisation.callPackageWith (self // {inherit sources;});
      directory = ../pkgs/custom;
    };
  };
}
