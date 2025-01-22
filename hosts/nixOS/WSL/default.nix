{ pkgs, hostname, ... }:

{
  imports = [
    ./../common
  ];

  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];

  networking = {
    computerName = "${hostname}";
    hostName = "${hostname}";
  };
}