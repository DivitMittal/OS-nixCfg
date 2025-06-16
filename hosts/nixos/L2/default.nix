{lib, ...}: {
  imports = lib.custom.scanPaths ./.;

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  system.stateVersion = "24.11";
}
