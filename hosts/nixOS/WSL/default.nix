{ pkgs, config, ... }:

{
  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];

  networking = {
    computerName = "${config.networking.hostName}";
    # hostName = "${hostname}"; # handled by easy-hosts
  };
}