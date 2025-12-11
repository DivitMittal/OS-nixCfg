{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.programs.spicetify-cli;
in {
  options = let
    inherit (lib) mkOption types mkEnableOption mkPackageOption;
  in {
    programs.spicetify-cli = {
      enable = mkEnableOption "spicetify-cli";
      package = mkPackageOption pkgs "spicetify-cli" {nullable = true;};

      settings = mkOption {
        type = types.str;
        default = "";
        example = lib.literalExpression ''
          [Setting]
          inject_theme_js = 1
        '';
        description = "The settings to apply";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];
    xdg.configFile."spicetify/config-xpui.ini" = mkIf (cfg.settings != "") {text = cfg.settings;};
  };
}
