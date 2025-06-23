{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.programs.hammerspoon;
  inherit (lib) mkIf;

  hammerspoonDir = pkgs.runCommand "hammerspoon-config" {} ''
    mkdir -p $out

    ${lib.optionalString (cfg.configPath != null) ''
      if [ -d "${cfg.configPath}" ]; then
        cp -r "${cfg.configPath}"/* $out/
      else
        cp "${cfg.configPath}" $out/init.lua
      fi
    ''}

    ${lib.optionalString (cfg.spoons != {}) ''
      mkdir -p $out/Spoons
      ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: source: ''
          cp -r "${source}" "$out/Spoons/${name}.spoon"
        '')
        cfg.spoons)}
    ''}
  '';
in {
  options = let
    inherit (lib) mkEnableOption mkOption types;
  in {
    programs.hammerspoon = {
      enable = mkEnableOption "Hammerspoon, a tool for automating macOS tasks";

      package = mkOption {
        type = types.nullOr types.package;
        default = null;
        description = ''
          The Hammerspoon package to use.
        '';
      };

      configPath = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = ''
          Path to a Hammerspoon configuration.
          If a file (typically init.lua), it will be copied to the hammerspoon config directory.
          If a directory, its contents will be copied to the hammerspoon config directory.
        '';
      };

      spoons = mkOption {
        type = types.attrsOf types.path;
        default = {};
        description = ''
          Attribute set of Hammerspoon Spoons to install.
          Keys are spoon names, values are paths to the spoon directories.
          Each spoon will be installed to the Spoons/ subdirectory.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    targets.darwin.defaults = {
      "org.hammerspoon.Hammerspoon".MJConfigFile = "${config.xdg.configHome}/hammerspoon/init.lua";
    };
    home.packages = mkIf (cfg.package != null) [ cfg.package ];
    xdg.configFile = mkIf (cfg.configPath != null || cfg.spoons != {}) {
      "hammerspoon" = {
        source = hammerspoonDir;
        recursive = true;
      };
    };
  };
}