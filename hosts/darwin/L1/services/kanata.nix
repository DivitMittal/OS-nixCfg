{ config, lib, ... }:

let
  inherit(lib) mkOption mkIf;
  cfg = config.services.kanata;
in
{
  options = let inherit(lib) types; in {
    services.kanata.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable kanata to launch on startup & run as a background daemon";
    };

    services.kanata.binary = mkOption {
      type = types.path;
      default = (/. + "${config.users.users.div.home}/.local/bin/kanata");
      description = "Path to the default kanata binary";
    };
  };

  config = mkIf (cfg.enable) {
    # launchd.agents =

    security.sudo.extraConfig = ''
      ALL ALL=(root) NOPASSWD: ${cfg.binary}
    '';
  };
}