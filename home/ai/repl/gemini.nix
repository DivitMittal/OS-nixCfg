{
  config,
  pkgs,
  inputs,
  hostPlatform,
  ...
}: {
  programs.gemini-cli = {
    enable = true;
    package = inputs.nix-ai-tools.packages.${hostPlatform.system}.gemini-cli;
    defaultModel = "gemini-2.5-pro";
    settings = {
      selectedAuthType = "gemini-api-key";
      theme = "ANSI";
      preferredEditor = "${config.home.sessionVariables.EDITOR}";
      vimMode = true;
      mcpServers = let
        pnpmCommand = "${pkgs.pnpm}/bin/pnpm";
        # uvCommand = "${pkgs.uv}/bin/uvx";
      in {
        ## modelcontextprotocol
        filesystem = {
          command = pnpmCommand;
          args = ["dlx" "@modelcontextprotocol/server-filesystem"];
        };
        sequential-thinking = {
          command = pnpmCommand;
          args = ["dlx" "@modelcontextprotocol/server-sequential-thinking"];
        };
        memory = {
          command = pnpmCommand;
          args = ["dlx" "@modelcontextprotocol/server-memory"];
        };
        ## microsoft
        # playwright = {
        #   command = "npx";
        #   args = ["-y" "@playwright/mcp"];
        # };
        # markitdown = {
        #   command = uvCommand;
        #   args = ["markitdown-mcp"];
        # };
        ## third-party
        deepwiki = {
          trust = true;
          httpUrl = "https://mcp.deepwiki.com/mcp";
        };
        octocode = {
          command = pnpmCommand;
          args = ["dlx" "octocode-mcp@latest"];
        };
        ddg = {
          command = pnpmCommand;
          args = ["dlx" "duckduckgo-mcp-server"];
        };
      };
    };

    commands = {
      fix-issue = {
        description = "Fix GitHub issue following coding standards";
        prompt = " You are a senior software engineer. Your task is to fix the following GitHub issue in a codebase, adhering to best practices and coding standards.";
      };
    };
  };
}
