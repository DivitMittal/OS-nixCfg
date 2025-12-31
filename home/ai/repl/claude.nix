{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    # ccusage = pkgs.writeShellScriptBin "ccusage" ''
    #   exec ${pkgs.pnpm}/bin/pnpm dlx ccusage@latest "$@"
    # '';
    inherit (pkgs.ai) ccusage;
    # claude-code-router = pkgs.writeShellScriptBin "ccr" ''
    #   exec ${pkgs.pnpm}/bin/pnpm dlx @musistudio/claude-code-router "$@"
    # '';
    inherit (pkgs.ai) claude-code-router;
    inherit (pkgs.ai) ccstatusline;
  };
  programs.claude-code = let
    pnpmCommand = "${pkgs.pnpm}/bin/pnpm";
    # uvCommand = "${pkgs.uv}/bin/uvx";
    # claude-code = pkgs.writeShellScriptBin "claude" ''
    #   exec ${pkgs.pnpm}/bin/pnpm dlx @anthropic-ai/claude-code "$@"
    # '';
  in {
    enable = true;
    package = pkgs.ai.claude-code;

    mcpServers = {
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
      ## microsoft
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
      ## Third-party
      deepwiki = {
        type = "http";
        url = "https://mcp.deepwiki.com/mcp";
      };
      octocode = {
        type = "stdio";
        command = pnpmCommand;
        args = ["dlx" "octocode-mcp@latest"];
      };
      # ddg = {
      #   type = "stdio";
      #   command = pnpmCommand;
      #   args = ["dlx" "duckduckgo-mcp-server"];
      # };
    };

    settings = {
      hooks = {
        PreToolUse = [
          {
            matcher = "Bash";
            hooks = [
              {
                type = "command";
                command = "echo 'Running command: $CLAUDE_TOOL_INPUT'";
              }
            ];
          }
        ];
        PostToolUse = [
          {
            matcher = "Edit|MultiEdit|Write";
            hooks = [
              {
                type = "command";
                command = "nix fmt $(jq -r '.tool_input.file_path' <<< '$CLAUDE_TOOL_INPUT')";
              }
            ];
          }
        ];
      };
      includeCoAuthoredBy = false;
      permissions = {
        # additionalDirectories = [ "../docs/" ];
        allow = [
          "Read"
          "Bash(git diff:*)"
          "Edit"
          "Write"

          ## MCPs
          ## Filesystem MCP
          "mcp__filesystem__*"
          ## Serena MCP
          "mcp__serena__*"
          ## Octocode MCP
          "mcp__octocode__*"
        ];
        ask = [
          "Bash(git push:*)"
          "Bash(git commit:*)"
        ];
        defaultMode = "acceptEdits";
        deny = [
          "WebFetch"
          "Read(./.env)"
          "Read(./secrets/**)"
        ];
        #disableBypassPermissionsMode = "disable";
      };
      statusLine = {
        command = "${pkgs.ai.ccstatusline}/bin/ccstatusline";
        padding = 0;
        type = "command";
      };
      theme = "dark";
      #outputStyle = "Explanatory";
    };

    commands = {
      changelog = ''
        ---
        allowed-tools: Bash(git log:*), Bash(git diff:*)
        argument-hint: [version] [change-type] [message]
        description: Update CHANGELOG.md with new entry
        ---
        Parse the version, change type, and message from the input
        and update the CHANGELOG.md file accordingly.
      '';
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
      fix-issue = ''
        ---
        allowed-tools: Bash(git status:*), Read
        argument-hint: [issue-number]
        description: Fix GitHub issue following coding standards
        ---
        Fix issue #$ARGUMENTS following our coding standards and best practices.
      '';
    };
  };
}
