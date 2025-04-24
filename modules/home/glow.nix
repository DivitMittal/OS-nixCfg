{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.programs.glow;
  yamlFormat = pkgs.formats.yaml {};
in {
  options = let
    inherit (lib) mkOption mkEnableOption mkPackageOption;
  in {
    programs.glow = {
      enable = mkEnableOption "glow";
      package = mkPackageOption pkgs "glow" {nullable = true;};

      settings = mkOption {
        inherit (yamlFormat) type;
        default = {};

        example = lib.literalExpression ''
          {
            style = "auto";
            mouse = true;
          }
        '';
        description = ''
          Configuration written to
          {file}`$XDG_CONFIG_HOME/glow/glow.yaml`.

          See <https://github.com/charmbracelet/glow?tab=readme-ov-file#the-config-file>
          for the full list of options.
        '';
      };
    };
  };

  config = (mkIf cfg.enable) {
    home.packages = mkIf (cfg.package != null) [cfg.package];
    xdg.configFile."glow/glow.yaml" = mkIf (cfg.settings != {}) {
      source = yamlFormat.generate "glow-settings.yaml" cfg.settings;
    };
  };
}
