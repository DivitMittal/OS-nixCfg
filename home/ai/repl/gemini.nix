{
  config,
  pkgs,
  ...
}: {
  programs.gemini-cli = {
    enable = true;
    package = pkgs.writeShellScriptBin "gemini" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx @google/gemini-cli "$@"
    '';
    # package = pkgs.ai.gemini-cli;
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
        # ddg = {
        #   command = pnpmCommand;
        #   args = ["dlx" "duckduckgo-mcp-server"];
        # };
      };
    };

    commands = {
      commit = {
        description = "Create git commit(s) with proper message(s)";
        prompt = ''
          ## Context

          - Current git status: !`git status`
          - Current git diff: !`git diff HEAD`
          - Recent commits: !`git log --oneline -5`

          ## Task

          Analyze the changes and create commit(s) based on the context:

          1. **Multiple commits when**:
             - Changes span multiple logical concerns (e.g., feature + refactor + docs)
             - Changes affect unrelated components or modules
             - User explicitly requests multiple commits or groups of changes

          2. **Single commit when**:
             - All changes relate to a single logical unit of work
             - User specifies a single context or scope
             - Changes form one cohesive story

          3. **Context-limited commits**:
             - If instructed to commit specific files/paths, ONLY stage and commit those files
             - Respect explicit scope boundaries provided by the user
             - Do NOT include unrelated staged or unstaged changes

          Each commit message MUST follow Conventional Commits syntax: `type(scope): description`

          When creating multiple commits:
          - Stage and commit related changes together
          - Use descriptive, focused commit messages for each
          - Maintain logical ordering (dependencies first)
        '';
      };
      fix-issue = {
        description = "Fix GitHub issue following coding standards";
        prompt = " You are a senior software engineer. Your task is to fix the following GitHub issue in a codebase, adhering to best practices and coding standards.";
      };
    };
  };
}
