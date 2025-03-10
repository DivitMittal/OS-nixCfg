{ pkgs, config, ... }:

{
  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];

  networking = {
    computerName = "${config.networking.hostname}";
    # hostName = "${hostname}"; # handled by easy-hosts
  };
}