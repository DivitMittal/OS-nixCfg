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
        allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
        description: Create a git commit with proper message
        ---
        ## Context

        - Current git status: !`git status`
        - Current git diff: !`git diff HEAD`
        - Recent commits: !`git log --oneline -5`

        ## Task

        Based on the changes above, create a single atomic git commit with a descriptive message.
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
