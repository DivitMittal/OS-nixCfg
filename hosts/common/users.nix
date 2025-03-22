{ user, pkgs, hostPlatform, ... }:

{
  nix.settings = {
    trusted-users = [ "root" "${user.username}" ];
  };

  users.users = {
    "${user.username}" = {
      description = "${user.username}";
      home = (if hostPlatform.isDarwin then "/Users" else "/home") + "/${user.username}";
      shell = pkgs.fish;
    };
  };
}