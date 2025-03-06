{ pkgs, lib, config,... }:

let
  inherit(lib) mkIf;
  tomlFormat = pkgs.formats.toml { };
  configFile = tomlFormat.generate "spotifyd.conf" cfg.settings;
  cfg = config.services.spotify-daemon;
in
{
  options = let inherit(lib) mkOption types; in {
    services.spotify-daemon = {
      enable = mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "To enable/disable spotifyd & run it as a LaunchAgent";
      };
      package = mkOption {
        type = types.path;
        default = /${pkgs.spotifyd}/bin/spotifyd; #impure
        example = "pkgs.spotifyd";
        description = "The spotifyd package to use";
      };
      settings = mkOption {
        type = tomlFormat.type;
        default = { };
        description = "Configuration for spotifyd";
        example = lib.literalExpression ''
          {
            global = {
              username = "Alex";
              password = "foo";
              device_name = "nix";
            };
          }
        '';
      };
    };
  };

  config = mkIf (cfg.enable) {
    launchd.user.agents.spotify-daemon = {
      script = "${cfg.package} --no-daemon --config-path ${configFile}";
      serviceConfig = {
        RunAtLoad = true;
        Nice = -19;
      };
    };
  };
}