{ config, pkgs, lib, ... }:

let
  inherit(lib) mkOption mkIf;
  cfg = config.services.kanata;
  configFile = mkIf (cfg.config != "") "${pkgs.writeScript "kanata.kbd" "${cfg.config}"}";
  command = if (cfg.config != "") then [ "sudo" "${cfg.package}" "-n" "-c" configFile ] else [ "sudo" "${cfg.package}" "-n" ];
in
{
  options = let inherit(lib) types; in {
    services.kanata.enable = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = "Whether to enable kanata & run it as a LaunchAgent";
    };

    services.kanata.package = mkOption {
      type = types.path;
      default = pkgs.kanata-with-cmd;
      example = pkgs.kanata;
      description = "The kanata package to use";
    };

    services.kanata.config = mkOption {
      type = types.str;
      default = "";
      example = ''
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

        (deflayer arrows
          _    _           up
                      left down rght
          _    _
        )

        (defalias
          cap (tap-hold-press 200 200 caps lctl)
          grv (tap-hold-press 200 200 grv (layer-toggle arrows))
        )
      '';
      description = "Your kanata configuration";
    };

    services.kanata.extraConfig = mkOption {
      type = types.str;
      default = "";
      example = ''
        (defsrc
          caps grv         i
                      j    k    l
          lsft rsft
        )
      '';
      description = "Your extra kanata configuration";
    };
  };

  config = mkIf (cfg.enable) {
    launchd.user.agents.kanata = {
      environment.SHELL = "/bin/dash";
      serviceConfig = {
        ProgramArguments = command;
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
      ALL ALL=(root) NOPASSWD: ${cfg.package}
    '';
  };
}