{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.programs.ov;
  yamlFormat = pkgs.formats.yaml {};
in {
  options = let
    inherit (lib) mkOption mkEnableOption mkPackageOption;
  in {
    programs.ov = {
      enable = mkEnableOption "ov";
      package = mkPackageOption pkgs "ov" {nullable = true;};

      settings = mkOption {
        inherit (yamlFormat) type;
        default = {};

        example = lib.literalExpression ''
          {
            General = {
              TabWidth = 4;
              WrapMode = true;
            };
          }
        '';
        description = ''
          Configuration written to
          {file}`$XDG_CONFIG_HOME/ov/config.yaml`.

          See <https://github.com/noborus/ov>
          for the full list of options.
        '';
      };
    };
  };

  config = (mkIf cfg.enable) {
    home.packages = mkIf (cfg.package != null) [cfg.package];
    xdg.configFile."ov/config.yaml" = mkIf (cfg.settings != {}) {
      source = yamlFormat.generate "ov-config.yaml" cfg.settings;
    };
  };
}
