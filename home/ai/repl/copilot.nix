{pkgs, ...}: {
  programs.github-copilot = let
    pnpmCommand = "${pkgs.pnpm}/bin/pnpm";
  in {
    enable = true;
    package = pkgs.writeShellScriptBin "copilot" ''
      exec ${pkgs.ai.copilot-cli}/bin/copilot --enable-all-github-mcp-tools --banner "$@"
    '';

    mcpServers = {
      ## modelcontextprotocol
      filesystem = {
        type = "local";
        command = pnpmCommand;
        args = ["dlx" "@modelcontextprotocol/server-filesystem"];
      };
      sequential-thinking = {
        type = "local";
        command = pnpmCommand;
        args = ["dlx" "@modelcontextprotocol/server-sequential-thinking"];
      };
      memory = {
        type = "local";
        command = pnpmCommand;
        args = ["dlx" "@modelcontextprotocol/server-memory"];
      };
      ## Third-party
      deepwiki = {
        type = "http";
        url = "https://mcp.deepwiki.com/mcp";
      };
      # octocode = {
      #   type = "local";
      #   command = pnpmCommand;
      #   args = ["dlx" "octocode-mcp@latest"];
      # };
      ddg = {
        type = "local";
        command = pnpmCommand;
        args = ["dlx" "duckduckgo-mcp-server"];
      };
    };

    settings = {
      permissions = {
        allow = [
          ## Filesystem MCP
          "mcp__filesystem__list_directory"
          "mcp__filesystem__edit_file"
          "mcp__filesystem__write_file"
          "mcp__filesystem__read_text_file"
          "mcp__filesystem__read_multiple_files"
          "mcp__filesystem__create_directory"
          "mcp__filesystem__directory_tree"

          ## Memory MCP
          "mcp__memory__store"
          "mcp__memory__retrieve"
          "mcp__memory__search"

          ## Octocode MCP
          "mcp__octocode__githubViewRepoStructure"
          "mcp__octocode__githubGetFileContent"
          "mcp__octocode__githubSearchCode"

          ## DuckDuckGo MCP
          "mcp__ddg__search"
        ];
        defaultMode = "acceptEdits";
        deny = [
          "WebFetch"
        ];
      };
      theme = "dark";
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
