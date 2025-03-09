{ pkgs, config, lib, ... }:

let
  inherit(lib) mkIf;
  cfg = config.programs.spicetify-cli;
in
{
  options = let inherit(lib) mkOption types; in {
    programs.spicetify-cli = {
      enable = mkOption {
        type = types.bool;
        default = false;
        example = "true";
        description = "Enable/Disable spicetify-cli";
      };

      package = mkOption {
        type = types.package;
        default = pkgs.spicetify-cli;
        example = "pkgs.spicetify-cli";
        description = "The package to install";
      };

      settings = mkOption {
        type = types.str;
        default = "";
        example = "[Setting]\ninject_theme_js = 1\ninject";
        description = "The settings to apply";
      };
    };
  };

  config = mkIf (cfg.enable) {
    home.packages = [ cfg.pacakge ];
    xdg.configFile."spicetify/config-xpui.ini" = mkIf (cfg.settings != "") { text = cfg.settings; };
  };
}