{
  pkgs,
  inputs,
  ...
}: {
  programs.crush = {
    enable = true;
    package = inputs.nix-ai-tools.packages.${pkgs.system}.crush;

    settings = {
      permissions = {
        allowed_tools = [
          "view"
          "ls"
          "grep"
          "edit"
          "mcp_context7_get-library-doc"
        ];
      };
      lsp = {
        go = {
          command = "gopls";
        };
        typescript = {
          command = "typescript-language-server";
          args = ["--stdio"];
        };
        nix = {
          command = "nixd";
        };
      };
      mcp = {
        ## modelcontextprotocol
        filesystem = {
          type = "stdio";
          command = "npx";
          args = ["-y" "@modelcontextprotocol/server-filesystem"];
        };
        sequential-thinking = {
          type = "stdio";
          command = "npx";
          args = ["-y" "@modelcontextprotocol/server-sequential-thinking"];
        };
        memory = {
          type = "stdio";
          command = "npx";
          args = ["-y" "@modelcontextprotocol/server-memory"];
        };
        ## Microsoft
        playwright = {
          type = "stdio";
          command = "npx";
          args = ["-y" "@playwright/mcp"];
        };
        ## third-party
        octocode = {
          type = "stdio";
          command = "npx";
          args = ["-y" "octocode-mcp@latest"];
        };
        ddg = {
          type = "stdio";
          command = "npx";
          args = ["duckduckgo-mcp-server"];
        };
      };
    };
  };
}
