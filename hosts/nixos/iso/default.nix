{
  pkgs,
  modulesPath,
  lib,
  inputs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    inputs.home-manager.nixosModules.home-manager
  ];

  image.fileName = lib.mkForce "nixos-custom-${pkgs.stdenvNoCC.hostPlatform.system}.iso";

  isoImage = {
    squashfsCompression = "zstd";
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
    };
  };

  users.users.root.initialPassword = "nixos";

  networking.wireless.enable = lib.mkForce false;
  networking.networkmanager.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {inherit inputs;};
    users.nixos = ./home.nix;
  };

  system.stateVersion = "24.11";
}
