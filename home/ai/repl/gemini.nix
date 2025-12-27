{
  config,
  pkgs,
  ...
}: {
  programs.gemini-cli = {
    enable = true;
    package = pkgs.ai.gemini-cli;
    defaultModel = "gemini-3-pro-preview";
    settings = {
      general = {
        preferredEditor = "${config.home.sessionVariables.EDITOR}";
        vimMode = true;
        previewFeatures = true;
        disableAutoUpdate = true;
        enablePromptCompletion = true;
      };
      security = {
        auth = {
          selectedType = "oauth-personal";
        };
      };
      ui = {
        theme = "ANSI";
        showStatusInTitle = true;
        footer = {
          hideContextPercentage = false;
        };
        showModelInfoInChat = true;
        showCitations = true;
        showMemoryUsage = true;
      };
      context = {
        loadMemoryFromIncludeDirectories = true;
      };
      tools = {
        shell = {
          showColor = true;
        };
      };
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
      commit = {
        description = "Create a git commit with proper message";
        prompt = ''
          ## Context

          - Current git status: !`git status`
          - Current git diff: !`git diff HEAD`
          - Recent commits: !`git log --oneline -5`

          ## Task

          Based on the changes above, create a single atomic git commit with a descriptive message.
          The commit message MUST follow Conventional Commits syntax: `type(scope): description`
        '';
      };
      fix-issue = {
        description = "Fix GitHub issue following coding standards";
        prompt = " You are a senior software engineer. Your task is to fix the following GitHub issue in a codebase, adhering to best practices and coding standards.";
      };
    };
  };
}
