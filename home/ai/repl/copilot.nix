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
