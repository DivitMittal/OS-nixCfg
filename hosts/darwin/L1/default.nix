{lib, ...}: {
  imports = lib.custom.scanPaths ./.;

  system.stateVersion = 4;
}