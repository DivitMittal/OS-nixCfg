{ config, lib, pkgs, ... }:

let
  inherit(lib) mkIf;
  cfg = config.services.kanata-tray;
  karabinerDaemon = "/Library/Application\\ Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon";
in
{
  options = let inherit(lib) mkEnableOption mkPackageOption types mkOption; in {
    services.kanata-tray = {
      enable = mkEnableOption "kanata-tray";
      package = mkPackageOption pkgs "kanata-tray" { nullable = true; };
      environment = mkOption {
        type = types.attrsOf types.str;
        default = {};
        example = lib.literalExpression ''
          {
            ENV_VAR1 = "value1";
          }
        '';
        description = "Environment variables to be set for kanata-tray & kanata";
      };
    };
  };

  config = mkIf (cfg.enable) {
    launchd.user.agents.kanata-tray = {
      inherit(cfg) environment;
      command = "sudo --preserve-env " + "${cfg.package}/bin/kanata-tray";
      serviceConfig = {
        RunAtLoad = true;
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        Nice = -19;
      };
    };

    launchd.user.agents.karabiner-daemon = {
      command = "sudo " + karabinerDaemon;
      serviceConfig = {
        RunAtLoad = true;
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        Nice = -19;
      };
    };

    environment.etc."sudoers.d/kanata-tray".source = pkgs.runCommand "sudoers-kanata-tray" {} ''
      cat <<EOF >"$out"
      ALL ALL=(ALL) NOPASSWD:SETENV: ${cfg.package}/bin/kanata-tray
      ALL ALL=(ALL) NOPASSWD: ${karabinerDaemon}
      EOF
    '';
  };
}