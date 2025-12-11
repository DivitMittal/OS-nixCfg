{lib, ...}: {
  imports = [
    ../../../home/tty
  ];

  options.hostSpec = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
    };
    userFullName = lib.mkOption {
      type = lib.types.str;
      default = "NixOS Live User";
    };
    handle = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "nixos@localhost";
    };
  };

  config = {
    home = {
      username = "nixos";
      homeDirectory = "/home/nixos";
      stateVersion = "24.11";
    };

    programs.home-manager.enable = true;
  };
}
