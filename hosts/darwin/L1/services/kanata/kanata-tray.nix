{ config, lib, pkgs, ... }:

let
  inherit(lib) mkIf;
  cfg = config.services.kanata-tray;
  karabinerDaemon = "/Library/Application\\ Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon";
in
{
  options = let inherit(lib) mkOption types; in {
    services.kanata-tray.enable = mkOption {
      type = types.bool;
      default = true;
      example = true;
      description = "To enable/disable kanata-tray & run it as a LaunchDaemon";
    };

    services.kanata-tray.package = mkOption {
      type = types.path;
      default = builtins.toPath "${config.paths.homeDirectory}/.local/bin/kanata-tray"; #impure
      example = "~/.local/bin/kanata-tray";
      description = "The kanata-tray package to use";
    };
  };

  config = mkIf (cfg.enable) {
    launchd.user.agents.kanata-tray = {
      environment = {
        # KANATA_TRAY_CONFIG_DIR = "${config.paths.homeDirectory}/.config/kanata-tray"
        KANATA_TRAY_LOG_DIR = "/tmp";
      };
      script = "sudo " + "${cfg.package}";
      serviceConfig = {
        RunAtLoad = true;
        KeepAlive.Crashed = true;
        KeepAlive.SuccessfulExit = false;
        Nice = -19;
      };
    };

    launchd.user.agents.karabiner-daemon = {
      script = "sudo " + karabinerDaemon;
      serviceConfig = {
        RunAtLoad = true;
        KeepAlive.Crashed = true;
        KeepAlive.SuccessfulExit = false;
        Nice = -19;
      };
    };

    environment.etc."sudoers.d/kanata-tray".source = pkgs.runCommand "sudoers-kanata-tray" {} ''
      cat <<EOF >"$out"
      ALL ALL=(ALL) NOPASSWD: ${cfg.package}
      ALL ALL=(ALL) NOPASSWD: ${karabinerDaemon}
      EOF
    '';
  };
}