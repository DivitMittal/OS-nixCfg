{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  yamlFormat = pkgs.formats.yaml {};
  cfg = config.programs.spotatui;
in {
  options = let
    inherit (lib) mkOption mkEnableOption mkPackageOption;
  in {
    programs.spotatui = {
      enable = mkEnableOption "spotatui";
      package = mkPackageOption pkgs "spotatui" {nullable = true;};
      settings = mkOption {
        inherit (yamlFormat) type;
        default = {};
        description = "Configuration for spotatui written to {file}`$XDG_CONFIG_HOME/spotatui/config.yml`.";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = mkIf (cfg.package != null) [cfg.package];
    xdg.configFile."spotatui/config.yml" = mkIf (cfg.settings != {}) {
      source = yamlFormat.generate "spotatui-config.yml" cfg.settings;
    };
  };
}
