{ pkgs, lib, config, ... }:

let
  inherit(lib) mkIf;
  tomlFormat = pkgs.formats.toml { };
  cfg = config.services.kanata-tray;
  configFile = tomlFormat.generate "kanata-tray.toml" cfg.settings;
in
{
  options = let inherit(lib) mkOption types; in {
    services.kanata-tray = {
      enable = mkOption {
        type = types.bool;
        default = false;
        example = "true";
        description = "Enable/Disable kanata-tray configuration";
      };

      kanataPackage = mkOption {
        type = types.package;
        default = pkgs.kanata;
        example = "pkgs.kanata";
        description = "Kanata binary/package to use";
      };

      settings = mkOption {
        type = tomlFormat.type;
        default = {};
        example = {
          general = {
            allow_concurrent_presets = false;
          };
          defaults = {
            kanata_executable = "/bin/kanata";
            tcp_port = 5830;
          };
        };
        description = "Configuration for kanata-tray";
      };
    };
  };

  config = (mkIf cfg.enable) {
    home.packages = [ cfg.kanataPackage ];
    home.file."${config.home.homeDirectory}/Library/Application Support/kanata-tray/kanata-tray.toml" = mkIf (cfg.settings != {}) { source = configFile; };
  };
}