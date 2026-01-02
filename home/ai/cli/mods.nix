{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  programs.mods = {
    enable = true;
    package = pkgs.mods;

    enableBashIntegration = false;
    enableFishIntegration = config.programs.fish.enable;
    # Disable automatic Zsh integration - loading it manually after compinit
    enableZshIntegration = false;

    settings = {
      default-model = "gpt-oss";

      roles = {
        shell = [
          "you are a shell expert"
          "you don't explain anything"
          "you simply output one liners to solve the problems you're asked"
          "you don't provide any explanation whatsoever, only the command"
        ];
      };

      apis = {
        groq = {
          base-url = "https://api.groq.com/openai/v1";
          api-key-env = "GROQ_API_KEY";
          models = {
            "openai/gpt-oss-120b" = {
              aliases = ["gpt-oss"];
              max-input-chars = 24500;
            };
            "qwen/qwen3-32b" = {
              aliases = ["qwen3"];
              max-input-chars = 24500;
            };
          };
        };
        google = {
          api-key-env = "GEMINI_API_KEY";
          models = {
            "gemini-3-flash-preview" = {
              aliases = ["gemini-flash"];
              max-input-chars = 392000;
            };
            "gemini-3-pro-preview" = {
              aliases = ["gemini-pro"];
              max-input-chars = 392000;
            };
          };
        };
        openrouter = {
          base-url = "https://openrouter.ai/api/v1";
          api-key-env = "OPENROUTER_API_KEY";
          models = {
            "deepseek/deepseek-chat-v3.1:free" = {
              aliases = ["deepseek"];
              max-input-chars = 24500;
            };
            "z-ai/glm-4.5-air:free" = {
              aliases = ["glm"];
              max-input-chars = 24500;
            };
          };
        };
      };
    };
  };

  # Manual Zsh integration - loaded after compinit to avoid "command not found: compdef" error
  programs.zsh = mkIf config.programs.zsh.enable {
    initContent = ''
      source <(${pkgs.mods}/bin/mods completion zsh)
    '';
  };
}
