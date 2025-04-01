{ pkgs, ... }:

{
  programs.aichat = {
    enable = true;
    package = pkgs.aichat;

    settings = {
      highlight = true;
      light_theme = false;
      left_prompt = "{color.green}{?session {?agent {agent}>}{session}{?role /}}{!session {?agent {agent}>}}{role}{?rag @{rag}}{color.cyan}{?session )}{!session >}{color.reset} ";
      right_prompt = "{color.purple}{?session {?consume_tokens {consume_tokens}({consume_percent}%)}{!consume_tokens {consume_tokens}}}{color.reset}";
      keybindings = "vim";
      editor = "nvim";
      wrap = "auto";
      wrap_code = false;
      clients = [
        {
          type = "openai-compatible";
          name = "groq";
          api_base = "https://api.groq.com/openai/v1";
          # api_key = ""; # Using environment variables instead
        }
        {
          type = "gemini";
          api_base = "https://generativelanguage.googleapis.com/v1beta";
          # api_key = ""; # Using environment variables instead
          patch = null;
          chat_completions = {
            ".*" = {
              body = {
                safetySettings = [
                  {
                    category = "HARM_CATEGORY_HARASSMENT";
                    threshold = "BLOCK_NONE";
                  }
                  {
                    category = "HARM_CATEGORY_HATE_SPEECH";
                    threshold = "BLOCK_NONE";
                  }
                  {
                    category = "HARM_CATEGORY_SEXUALLY_EXPLICIT";
                    threshold = "BLOCK_NONE";
                  }
                  {
                    category = "HARM_CATEGORY_DANGEROUS_CONTENT";
                    threshold = "BLOCK_NONE";
                  }
                ];
              };
            };
          };
        }
      ];
    };
  };
}