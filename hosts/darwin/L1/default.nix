{ config, username, hostname, pkgs, pkgs-darwin, ... }:

{
  imports = [
    ./../common
    ./apps
    ./defaults
    ./services
  ];

  environment.darwinConfig = "${config.paths.currentDarwinCfg}/default.nix";

  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];

  networking = {
    computerName = "${hostname}";
    hostName = "${hostname}";
  };

  nix.settings = {
    trusted-users = [ "root" "${username}" ];
  };

  users.users = {
    "${username}" = {
      description = "${username}";
      home = "/Users/${username}";
      shell = pkgs-darwin.fish;
    };
  };
}