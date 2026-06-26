{lib, ...}: {
  # UEFI/systemd-boot — Lima VMs (both vz and qemu) expose UEFI firmware
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # virtio drivers required for Lima disk, network, and balloon devices
  boot.initrd.kernelModules = [
    "virtio_pci"
    "virtio_scsi"
    "virtio_blk"
    "virtio_net"
    "virtio_balloon"
  ];

  # Lima manages DHCP/DNS in the VM; NetworkManager is not needed here
  # (common/hosts/nixos/networking.nix sets networkmanager.enable = true which we override)
  networking = {
    networkmanager.enable = lib.mkForce false;
    useDHCP = lib.mkDefault true;
  };

  # SSH is the primary entry point from the macOS host (colima ssh / limactl shell)
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  # QEMU guest agent — VM lifecycle events and graceful shutdown from the host
  services.qemuGuest.enable = true;
}
