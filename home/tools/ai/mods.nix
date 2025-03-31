{ pkgs, config, ... }:

{
  programs.mods = {
    enable = true;
    package = pkgs.mods;
    enableBashIntegration = false; enableFishIntegration = true; enableZshIntegration = true;
    settings = {
      default-model = "deepseek-r1-distill-llama-70b";

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
          api-key = (builtins.readFile config.sops.secrets."api-keys/GROQ_API_KEY".path);
          models = {
            "deepseek-r1-distill-llama-70b" = {
              aliases = [ "deepseek" ];
              max-input-chars = 24500;
            };
          };
        };
        google = {
          api-key = (builtins.readFile config.sops.secrets."api-keys/GEMINI_API_KEY".path);
          models = {
            "gemini-2.0-flash" = {
              aliases = [ "gemini-2.0-flash" ];
              max-input-chars = 392000;
            };
          };
        };
      };
    };
  };
}