{
  pkgs,
  lib,
  config,
  hostPlatform ? pkgs.stdenvNoCC.hostPlatform,
  ...
}: let
  inherit (lib) mkIf;
  tomlFormat = pkgs.formats.toml {};
  configFile = tomlFormat.generate "config.toml" cfg.settings;
  cfg = config.programs.wiki-tui;
in {
  options = let
    inherit (lib) mkOption mkEnableOption mkPackageOption;
  in {
    programs.wiki-tui = {
      enable = mkEnableOption "wiki-tui";
      package = mkPackageOption pkgs "wiki-tui" {nullable = true;};
      settings = mkOption {
        inherit (tomlFormat) type;
        default = {};
        description = ''
          Configuration written to
          {file}`$XDG_CONFIG_HOME/wiki-tui/config.toml` (on linux)
          {file}`$HOME/Library/Application Support/com.builditluc.wiki-tui/config.toml` (on darwin)

          See <https://wiki-tui.net/latest/configuration> for the full list of options.
        '';
        example = lib.literalExpression ''
          {
            bindings.global = {
              scroll_down = "down";
              scroll_up = "up";
            };
          }
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = mkIf (cfg.package != null) [cfg.package];
    home.file.wiki-tui = {
      enable = cfg.settings != {};
      source = configFile;
      target =
        if hostPlatform.isDarwin
        then "${config.home.homeDirectory}/Library/Application Support/com.builditluc.wiki-tui/config.toml"
        else "${config.xdg.configHome}/wiki-tui/config.toml";
    };
  };
}
