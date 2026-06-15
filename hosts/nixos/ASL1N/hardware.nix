{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-apple-silicon.nixosModules.default
  ];

  hardware.asahi = {
    enable = true;
    # Extract Wi-Fi/Bluetooth firmware from the Asahi EFI partition at build time
    extractPeripheralFirmware = true;
  };

  boot.initrd.availableKernelModules = ["nvme" "usb_storage" "usbhid" "xhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  networking.useDHCP = lib.mkDefault true;

  # EFI partition created by the Asahi Linux installer (contains U-Boot — do not reformat).
  # Identify the correct partition number with: lsblk -f /dev/nvme0n1
  # Update the device path before running nixos-install.
  fileSystems."/boot" = {
    device = "/dev/nvme0n1p4"; # Adjust partition number to match your Asahi layout
    fsType = "vfat";
    options = ["umask=0077" "noatime"];
    neededForBoot = true;
  };
}
