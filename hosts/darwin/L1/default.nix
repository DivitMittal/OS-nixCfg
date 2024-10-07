{ config, lib, hostname, pkgs, ... }:

let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "CascadiaCode"
    ];
  };
in
{
  imports = [
    ./../common
    ./apps
    ./defaults
    ./services
    ./users.nix
  ];

  environment.darwinConfig = "${config.paths.currentDarwinCfg}/default.nix";

  fonts.packages = [ nerdfonts ];

  networking = {
    computerName = "${hostname}";
    hostName = "${hostname}";
  };
}