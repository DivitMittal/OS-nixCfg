{pkgs, ...}: {
  programs.crush = {
    enable = false;
    package = pkgs.ai.crush;

    settings = {
      permissions = {
        allowed_tools = [
          "view"
          "ls"
          "grep"
          "edit"
        ];
      };
      lsp = {
        nix = {
          command = "${pkgs.nixd}/bin/nixd";
        };
        html = {
          command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
          args = ["--stdio"];
        };
        css = {
          command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
          args = ["--stdio"];
        };
        json = {
          command = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
          args = ["--stdio"];
        };
        svelte = {
          command = "${pkgs.nodePackages.svelte-language-server}/bin/svelteserver";
          args = ["--stdio"];
        };
        emmet = {
          command = "${pkgs.emmet-language-server}/bin/emmet-language-server";
          args = ["--stdio"];
        };
        haskell = {
          command = "${pkgs.haskell-language-server}/bin/haskell-language-server-wrapper";
          args = ["--lsp"];
        };
        python = {
          command = "${pkgs.python3Packages.python-lsp-server}/bin/pylsp";
        };
        lua = {
          command = "${pkgs.lua-language-server}/bin/lua-language-server";
        };
        yaml = {
          command = "${pkgs.yaml-language-server}/bin/yaml-language-server";
          args = ["--stdio"];
        };
      };
      mcp = let
        pnpmCommand = "${pkgs.pnpm}/bin/pnpm";
        # uvCommand = "${pkgs.uv}/bin/uvx";
      in {
        ## modelcontextprotocol
        filesystem = {
          type = "stdio";
          command = pnpmCommand;
          args = ["dlx" "@modelcontextprotocol/server-filesystem"];
        };
        sequential-thinking = {
          type = "stdio";
          command = pnpmCommand;
          args = ["dlx" "@modelcontextprotocol/server-sequential-thinking"];
        };
        memory = {
          type = "stdio";
          command = pnpmCommand;
          args = ["dlx" "@modelcontextprotocol/server-memory"];
        };
        ## Microsoft
        # playwright = {
        #   type = "stdio";
        #   command = pnpmCommand;
        #   args = ["dlx" "@playwright/mcp"];
        # };
        # markitdown = {
        #   type = "stdio";
        #   command = uvCommand;
        #   args = ["markitdown-mcp"];
        # };
        ## third-party
        deepwiki = {
          type = "http";
          url = "https://mcp.deepwiki.com/mcp";
        };
        octocode = {
          type = "stdio";
          command = pnpmCommand;
          args = ["dlx" "octocode-mcp@latest"];
        };
        ddg = {
          type = "stdio";
          command = pnpmCommand;
          args = ["dlx" "duckduckgo-mcp-server"];
        };
      };
    };

    commands = {
      commit = ''
        ---
        allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*)
        description: Create git commit(s) with proper message(s)
        ---
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
  };
}
