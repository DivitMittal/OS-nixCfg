{ config, pkgs, ... }:

{
  nix.settings = {
    trusted-users = [ "root" "${config.hostSpec.username}" ];
  };

  users.users = {
    "${config.hostSpec.username}" = {
      inherit(config.hostSpec) home;
      description = "${config.hostSpec.username}@${config.hostSpec.hostName}";
      shell = pkgs.fish;
    };
  };
}