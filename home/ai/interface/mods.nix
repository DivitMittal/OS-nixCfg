{pkgs, ...}: {
  programs.mods = {
    enable = true;
    package = pkgs.mods;

    enableBashIntegration = false;
    enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      default-model = "kimi-instruct";

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
            "deepseek-r1-distill-llama-70b" = {
              aliases = ["deepseek"];
              max-input-chars = 24500;
            };
            "moonshotai/kimi-k2-instruct" = {
              aliases = ["kimi-instruct"];
              max-input-chars = 24500;
            };
          };
        };
        google = {
          api-key-env = "GEMINI_API_KEY";
          models = {
            "gemini-2.5-flash" = {
              aliases = ["gemini-flash"];
              max-input-chars = 392000;
            };
            "gemini-2.5-pro" = {
              aliases = ["gemini-pro"];
              max-input-chars = 392000;
            };
          };
        };
        openrouter = {
          base-url = "https://openrouter.ai/api/v1";
          api-key-env = "OPENROUTER_API_KEY";
          models = {
            "qwen/qwen3-coder:free" = {
              aliases = ["qwen3-coder"];
              max-input-chars = 24500;
            };
            "moonshotai/kimi-k2:free" = {
              aliases = ["kimi"];
              max-input-chars = 24500;
            };
          };
        };
      };
    };
  };
}
