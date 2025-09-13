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

      mcp = let
        pnpmCommand = ["${pkgs.pnpm}/bin/pnpm" "dlx"];
        # uvCommand = ["${pkgs.uv}/bin/uvx"];
      in {
        ## modelcontextprotocol
        filesystem = {
          enabled = true;
          type = "local";
          command = pnpmCommand ++ ["@modelcontextprotocol/server-filesystem"];
        };
        memory = {
          enabled = true;
          type = "local";
          command = pnpmCommand ++ ["@modelcontextprotocol/server-memory"];
        };
        sequential-thinking = {
          enabled = true;
          type = "local";
          command = pnpmCommand ++ ["@modelcontextprotocol/server-sequential-thinking"];
        };
        ## microsoft
        # playwright = {
        #   enabled = false;
        #   type = "local";
        #   command = pnpmCommand ++ ["@playwright/mcp"];
        # };
        # markitdown = {
        #   enabled = true;
        #   type = "local";
        #   command = uvCommand ++ ["markitdown-mcp"];
        # };
        ## third-party
        deepwiki = {
          enabled = true;
          type = "remote";
          url = "https://mcp.deepwiki.com/mcp";
        };
        octocode = {
          enabled = true;
          type = "local";
          command = pnpmCommand ++ ["octocode-mcp@latest"];
        };
        ddg = {
          enabled = true;
          type = "local";
          command = pnpmCommand ++ ["duckduckgo-mcp-server"];
        };
      };
    };
  };
}
