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

      # Packages common to only instances of L1 with div user & not all macOS hosts & installed in nix-darwin profile
      packages = builtins.attrValues {
        inherit(pkgs-darwin)
          blueutil
          duti
        ;
      };
    };
  };
}