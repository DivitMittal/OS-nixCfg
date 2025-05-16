final: prev:
prev.lib.packagesFromDirectoryRecursive {
  callPackage = prev.lib.packages.callPackageWith final;
  directory = ./bins;
}