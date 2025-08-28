{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.gemini-cli = {
    enable = true;
    package = inputs.nix-ai-tools.packages.${pkgs.system}.gemini-cli;

    defaultModel = "gemini-2.5-pro";
    settings = {
      selectedAuthType = "gemini-api-key";
      theme = "ANSI";
      preferredEditor = "${config.home.sessionVariables.EDITOR}";
      vimMode = true;
      mcpServers = {
        ## modelcontextprotocol
        filesystem = {
          command = "npx";
          args = ["-y" "@modelcontextprotocol/server-filesystem" "/tmp"];
        };
        sequential-thinking = {
          command = "npx";
          args = ["-y" "@modelcontextprotocol/server-sequential-thinking"];
        };
        memory = {
          command = "npx";
          args = ["-y" "@modelcontextprotocol/server-memory"];
        };
        ## microsoft
        playwright = {
          command = "npx";
          args = ["-y" "@playwright/mcp"];
        };
        ## third-party
        octocode = {
          command = "npx";
          args = ["-y" "octocode-mcp@latest"];
        };
        ddg = {
          command = "npx";
          args = ["duckduckgo-mcp-server"];
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
