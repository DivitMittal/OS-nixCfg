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
        allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
        description: Create a git commit with proper message
        ---
        ## Context

        - Current git status: !`git status`
        - Current git diff: !`git diff HEAD`
        - Recent commits: !`git log --oneline -5`

        ## Task

        Based on the changes above, create a single atomic git commit with a descriptive message.
        The commit message MUST follow Conventional Commits syntax: `type(scope): description`
      '';
    };
  };
}
