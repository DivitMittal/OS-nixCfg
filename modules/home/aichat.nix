{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.programs.aichat;
  yamlFormat = pkgs.formats.yaml {};
in {
  options = let
    inherit (lib) mkOption mkEnableOption mkPackageOption;
  in {
    programs.aichat = {
      enable = mkEnableOption "aichat";
      package = mkPackageOption pkgs "aichat" {nullable = true;};

      settings = mkOption {
        type = yamlFormat.type;
        default = {};

        example = lib.literalExpression ''
          {
            keybindings = "vim";
            editor = "nvim";
            wrap = "auto";
            wrap_code = false;
            clients = [
              {
                type = "openai-compatible";
                name = "groq";
                api_base = "https://api.groq.com/openai/v1";
                api_key = "";
              }
            ];
          };
        '';
        description = ''
          Configuration written to
          {file}`$XDG_CONFIG_HOME/aichat/config.yaml`.

          See <https://github.com/sigoden/aichat/blob/main/config.example.yaml>
          for the full list of options.
        '';
      };
    };
  };

  config = (mkIf cfg.enable) {
    home.packages = mkIf (cfg.package != null) [cfg.package];
    xdg.configFile."aichat/config.yaml" = mkIf (cfg.settings != {}) {
      source = yamlFormat.generate "aichat-settings.yaml" cfg.settings;
    };
  };
}
