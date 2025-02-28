{ username, pkgs, config, ... }:

{
  nix.settings = {
    trusted-users = [ "root" "${username}" ];
  };

  users.users = {
    "${username}" = {
      description = "${username}";
      home = "${config.paths.homeDirectory}";
      shell = pkgs.fish;
    };
  };
}