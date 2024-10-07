{ username, config, lib, ... }:

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
      default = /Users/${username}/.local/bin/kanata;
      description = "Path to the default kanata binary";
    };

    services.kanata.cfg = mkOption {
      type = types.path;
      default = /Users/${username}/.config/kanata/kanata.kbd;
      description = "Path to the default config";
    };
  };

  config = mkIf (cfg.enable) {
    launchd.user.agents.kanata = {
      environment.SHELL = "/bin/dash";
      serviceConfig = {
        ProgramArguments = [ "sudo" "${cfg.binary}" "--cfg" "${cfg.cfg}" ];
        StandardOutPath = /tmp/org.nixos.kanata.out.log;
        StandardErrorPath = /tmp/org.nixos.kanata.err.log;
        ProcessType = "Interactive";
        RunAtLoad = true;
        KeepAlive.SuccessfulExit = false;
        KeepAlive.Crashed = true;
        Nice = -19;
      };
    };

    security.sudo.extraConfig = ''
      ALL ALL=(root) NOPASSWD: ${cfg.binary}
    '';
  };
}