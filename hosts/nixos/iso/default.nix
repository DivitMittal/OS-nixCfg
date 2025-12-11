{
  pkgs,
  modulesPath,
  lib,
  inputs,
  self,
  hostPlatform,
  ...
}: {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    inputs.home-manager.nixosModules.home-manager
  ];

  # Override hostSpec for the ISO live environment
  hostSpec = {
    username = lib.mkForce "nixos";
    userFullName = lib.mkForce "NixOS Live User";
    handle = lib.mkForce "nixos";
    email = lib.mkForce {
      dev = "nixos@localhost";
    };
    hostName = lib.mkForce "nixos-live";
    home = lib.mkForce "/home/nixos";
  };

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

    extraSpecialArgs = {inherit inputs self hostPlatform;};
    sharedModules = [
      ./hostSpec-hm.nix
      self.outputs.homeManagerModules.default
    ];
    users.nixos = ./home.nix;
  };

  system.stateVersion = "24.11";
}
