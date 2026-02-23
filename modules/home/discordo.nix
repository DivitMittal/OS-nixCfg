{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (pkgs.stdenv) isDarwin;
  cfg = config.programs.discordo;
  tomlFormat = pkgs.formats.toml {};

  # Darwin: ~/Library/Application Support/discordo/config.toml
  # Unix: $XDG_CONFIG_HOME/discordo/config.toml
  configDir =
    if isDarwin
    then "Library/Application Support/discordo"
    else "discordo";
  configPath =
    if isDarwin
    then "${configDir}/config.toml"
    else "${configDir}/config.toml";
in {
  options = let
    inherit (lib) mkOption mkEnableOption mkPackageOption;
  in {
    programs.discordo = {
      enable = mkEnableOption "discordo, a lightweight Discord terminal client";
      package = mkPackageOption pkgs "discordo" {nullable = true;};

      settings = mkOption {
        inherit (tomlFormat) type;
        default = {};

        example = lib.literalExpression ''
          {
            mouse = true;
            status = "online";
            messages_limit = 50;

            timestamps = {
              enabled = true;
              format = "3:04PM";
            };

            keybinds = {
              quit = "Ctrl+C";
              focus_guilds_tree = "Ctrl+G";
              focus_messages_list = "Ctrl+T";
            };

            theme.border = {
              enabled = true;
              normal_set = "round";
              active_set = "round";
            };
          }
        '';
        description = ''
          Configuration written to discordo's config.toml.

          On Darwin: {file}`~/Library/Application Support/discordo/config.toml`
          On Linux: {file}`$XDG_CONFIG_HOME/discordo/config.toml`

          See <https://github.com/ayn2op/discordo/blob/main/internal/config/config.toml>
          for the full list of options.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = mkIf (cfg.package != null) [cfg.package];

    # Darwin uses ~/Library/Application Support, not XDG
    home.file.${configPath} = mkIf (isDarwin && cfg.settings != {}) {
      source = tomlFormat.generate "discordo-config.toml" cfg.settings;
    };

    xdg.configFile.${configPath} = mkIf (!isDarwin && cfg.settings != {}) {
      source = tomlFormat.generate "discordo-config.toml" cfg.settings;
    };
  };
}
