{
  modulesPath,
  lib,
  hostPlatform,
  ...
}: {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  image.fileName = lib.mkForce "nixos-custom-${hostPlatform.system}.iso";

  isoImage = {
    squashfsCompression = "zstd";
  };

  users.users.root.initialPassword = "nixos";

  ## Use Network Manager
  networking.wireless.enable = lib.mkForce false;
  networking.networkmanager.enable = true;

  system.stateVersion = "24.11";
}
