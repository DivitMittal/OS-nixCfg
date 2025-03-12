{ config, pkgs, lib, ... }:

let
  inherit(lib) mkIf optionals;
  cfg = config.services.kanata;
  karabinerDaemon = "/Library/Application\\ Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon";
  configFile = mkIf (cfg.config != "") "${pkgs.writeScript "kanata.kbd" "${cfg.config}"}";
  command = ["${cfg.package}" "--nodelay"] ++ optionals (cfg.config != "") ["--cfg" configFile];
in
{
  options = let inherit(lib) mkOption types; in {
    services.kanata = {
      enable = mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "To enable/disable kanata & run it as launchd LaunchDaemon";
      };

      package = mkOption {
        type = types.package;
        default = pkgs.kanata;
        example = pkgs.kanata;
        description = "The kanata package to use";
      };

      config = mkOption {
        type = types.str;
        default = "";
        example = lib.literalExpression ''
          (defsrc
            caps grv         i
                        j    k    l
            lsft rsft
          )

          (deflayer default
            @cap @grv        _
                        _    _    _
            _    _
          )

          (defalias
            cap (tap-hold-press 200 200 caps lctl)
            grv (tap-hold-press 200 200 grv (layer-toggle arrows))
          )
        '';
        description = ''
          Your kanata configuration in the kanata lisp-like configuration language
        '';
      };
    };
  };

  config = mkIf (cfg.enable) {
    launchd.daemons.kanata = {
      script = "sudo " + "${builtins.concatStringsSep " " command}";
      serviceConfig = {
        StandardOutPath = /tmp/org.nixos.kanata.out.log;
        StandardErrorPath = /tmp/org.nixos.kanata.err.log;
        RunAtLoad = true;
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        Nice = -19;
      };
    };

    launchd.daemons.karabiner-daemon = {
      script = "sudo " + karabinerDaemon;
      serviceConfig = {
        RunAtLoad = true;
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        Nice = -19;
      };
    };

    # security.sudo.extraConfig = ''
    #   ALL ALL=(ALL) NOPASSWD: ${builtins.concatStringsSep " " command}
    # '';
    environment.etc."sudoers.d/kanata".source = pkgs.runCommand "sudoers-kanata" {} ''
      cat <<EOF >"$out"
      ALL ALL=(ALL) NOPASSWD: ${builtins.concatStringsSep " " command}
      ALL ALL=(ALL) NOPASSWD: ${karabinerDaemon}
      EOF
    '';
  };
}