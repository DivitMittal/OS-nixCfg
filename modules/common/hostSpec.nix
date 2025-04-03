{
  config,
  lib,
  hostPlatform,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.hostSpec = {
    username = mkOption {
      type = types.str;
      description = "The username of the host";
    };
    hostName = mkOption {
      type = types.str;
      description = "The hostname of the host";
    };
    email = mkOption {
      type = types.attrsOf types.str;
      description = "The email of the user";
    };
    userFullName = mkOption {
      type = types.str;
      description = "The full name of the user";
    };
    handle = mkOption {
      type = types.str;
      description = "The handle of the user (eg: github user)";
    };
    home = mkOption {
      type = types.str;
      description = "The home directory of the user";
      default = let
        user = config.hostSpec.username;
      in
        if hostPlatform.isDarwin
        then "/Users/${user}"
        else "/home/${user}";
    };
    # persistFolder = mkOption {
    #   type = types.str;
    #   description = "The folder to persist data if impermenance is enabled";
    #   default = "";
    # };
    #
  };
}
