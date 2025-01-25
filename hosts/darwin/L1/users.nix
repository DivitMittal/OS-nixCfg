{ username, pkgs-darwin, ... }:

{
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