{
  pkgs,
  inputs,
  ...
}: {
  programs.opencode = {
    enable = true;
    package = inputs.nix-ai-tools.packages.${pkgs.system}.opencode;

    rules = ''
      ## External File Loading

      CRITICAL: When you encounter a file reference (e.g., @rules/general.md), use your Read tool to load it on a need-to-know basis. They're relevant to the SPECIFIC task at hand.

      Instructions:

      - Do NOT preemptively load all references - use lazy loading based on actual need
      - When loaded, treat content as mandatory instructions that override defaults
      - Follow references recursively when needed
    '';

    settings = {
      autoupdate = false;
      autoshare = false;
      theme = "system";
      instructions = ["CLAUDE.md"];

      lsp = {
        nix = {
          command = ["nixd"];
          extensions = ["nix"];
        };
      };

      formatter = {
        nix = {
          command = ["alejandra"];
          extensions = ["nix"];
        };
      };

      mcp = {
        ## modelcontextprotocol
        filesystem = {
          enabled = true;
          type = "local";
          command = ["npx" "-y" "@modelcontextprotocol/server-filesystem" "/tmp"];
        };
        memory = {
          enabled = true;
          type = "local";
          command = ["npx" "-y" "@modelcontextprotocol/server-memory"];
        };
        sequential-thinking = {
          enabled = true;
          type = "local";
          command = ["npx" "-y" "@modelcontextprotocol/server-sequential-thinking"];
        };
        ## microsoft
        playwright = {
          enabled = true;
          type = "local";
          command = ["npx" "-y" "@playwright/mcp"];
        };
        ## third-party
        octocode = {
          enabled = true;
          type = "local";
          command = ["npx" "-y" "octocode-mcp@latest"];
        };
        ddg = {
          enabled = true;
          type = "local";
          command = ["npx" "-y" "duckduckgo-mcp-server"];
        };
      };
    };
  };
}
