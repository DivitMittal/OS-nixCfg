{ user, pkgs, config, ... }:

{
  nix.settings = {
    trusted-users = [ "root" "${user.username}" ];
  };

  users.users = {
    "${user.username}" = {
      description = "${user.username}";
      home = "${config.paths.homeDirectory}";
      shell = pkgs.fish;
    };
  };
}