{ config, lib, hostname, pkgs, ... }:

{
  imports = [
    ./../common
    ./apps
    ./defaults
    ./services
    ./users.nix
  ];

  environment.darwinConfig = "${config.paths.currentDarwinCfg}/default.nix";

  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];

  networking = {
    computerName = "${hostname}";
    hostName = "${hostname}";
  };
}