{ pkgs, ... }:

{
  imports = [
    ./users.nix
  ];

  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  networking.firewall = {
    enable = false;
  };

  system.stateVersion = "24.11";
}