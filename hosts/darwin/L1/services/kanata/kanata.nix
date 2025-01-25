{ config, pkgs, lib, ... }:

let
  inherit(lib) mkIf optionals;
  cfg = config.services.kanata;
  configFile = mkIf (cfg.config != "") "${pkgs.writeScript "kanata.kbd" "${cfg.config}"}";
  command = ["${cfg.package}" "--nodelay"] ++ optionals (cfg.config != "") ["--cfg" configFile] ++ optionals (cfg.config == "") ["--cfg" "${cfg.configPath}"];
in
{
  options = let inherit(lib) mkOption types; in {
    services.kanata.enable = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = "To enable/disable kanata & run it as launchd LaunchDaemon";
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

    services.kanata.configPath = mkOption {
      type = types.path;
      default = builtins.toPath "${config.paths.homeDirectory}/.config/kanata/kanata.kbd";
      example = "~/.config/kanata/kanata.kbd";
      description = "Your kanata configuration's path";
    };
  };

  config = mkIf (cfg.enable) {
    launchd.daemons.kanata = {
      script = "${builtins.concatStringsSep " " command}";
      serviceConfig = {
        StandardOutPath = /tmp/org.nixos.kanata.out.log;
        StandardErrorPath = /tmp/org.nixos.kanata.err.log;
        RunAtLoad = true;
        KeepAlive.SuccessfulExit = false;
        KeepAlive.Crashed = true;
        Nice = -19;
      };
    };

    # security.sudo.extraConfig = ''
    #   ALL ALL=(ALL) NOPASSWD: ${builtins.concatStringsSep " " command}
    # '';
    environment.etc."sudoers.d/kanata".source = pkgs.runCommand "sudoers-kanata" {} ''
      cat <<EOF >"$out"
      ALL ALL=(ALL) NOPASSWD: ${builtins.concatStringsSep " " command}
      EOF
    '';
  };
}