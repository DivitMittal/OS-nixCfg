{lib, ...}: {
  # Define hostSpec options for home-manager when used as a NixOS module
  # This allows ISO home configuration to work without access to OS-nixCfg-secrets
  options.hostSpec = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "User's username";
    };
    userFullName = lib.mkOption {
      type = lib.types.str;
      description = "User's full name";
    };
    handle = lib.mkOption {
      type = lib.types.str;
      description = "User's handle";
    };
    email = lib.mkOption {
      type = lib.types.attrs;
      description = "User's email addresses";
    };
    home = lib.mkOption {
      type = lib.types.str;
      description = "User's home directory";
    };
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "Hostname";
    };
  };

  # Set default values for ISO environment
  config.hostSpec = lib.mkDefault {
    username = "nixos";
    userFullName = "NixOS Live User";
    handle = "nixos";
    email.dev = "nixos@localhost";
    home = "/home/nixos";
    hostName = "nixos-live";
  };
}
