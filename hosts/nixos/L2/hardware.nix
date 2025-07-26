{lib, ...}: {
  boot.initrd.availableKernelModules = ["uhci_hcd" "xhci_pci" "ehci_pci" "ata_piix" "ahci" "sd_mod" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4fddd84e-9f1c-4681-9591-e821f50a9c35";
    fsType = "xfs";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/de0845b2-e3cb-4b0c-8c91-6083ab53fb75";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s5.useDHCP = lib.mkDefault true;

  hardware.parallels.enable = true;
}
