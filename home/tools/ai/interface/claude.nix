{
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    ccusage = pkgs.writeShellScriptBin "ccusage" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx ccusage "$@"
    '';
  };

  programs.claude-code = {
    enable = true;
    package = inputs.nix-ai-tools.packages.${pkgs.system}.claude-code;

    mcpServers = let
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
          "Search(pattern:*)"
          "Write"
          "Web Search"

          ## Filesystem MCP
          "mcp__filesystem__list_directory"
          "mcp__filesystem__edit_file"
          "mcp__filesystem__write_file"
          "mcp__filesystem__read_text_file"
          "mcp__filesystem__read_multiple_files"
          "mcp__filesystem__create_directory"
          "mcp__filesystem__directory_tree"

          ## Serena MCP
          "mcp__serena__activate_project"
          "mcp__serena__onboarding"
          "mcp__serena__find_file"
          "mcp__serena__check_onboarding_performed"
          "mcp__serena__write_memory"
          "mcp__serena__list_dir"
          "mcp__serena__find_symbol"
          "mcp__serena__insert_after_symbol"
          "mcp__serena__get_symbols_overview"
          "mcp__serena__replace_symbol_body"
          "mcp__serena__search_for_pattern"

          ## Octocode MCP
          "mcp__octocode__githubViewRepoStructure"
          "mcp__octocode__githubGetFileContent"
          "mcp__octocode__githubSearchCode"
        ];
        ask = [
          "Bash(git push:*)"
          "Bash(git commit:*)"
        ];
        defaultMode = "acceptEdits";
        deny = [
          "WebFetch"
          "Bash(curl:*)"
          "Read(./.env)"
          "Read(./secrets/**)"
        ];
        disableBypassPermissionsMode = "disable";
      };
      statusLine = {
        command = "input=$(cat); echo \"[$(echo \"$input\" | jq -r '.model.display_name')] 📁 $(basename \"$(echo \"$input\" | jq -r '.workspace.current_dir')\")\"";
        padding = 0;
        type = "command";
      };
      theme = "dark";
      outputStyle = "Explanatory";
    };

    agents = {
      code-reviewer = ''
        ---
        name: code-reviewer
        description: Specialized code review agent
        tools: Read, Edit, Grep
        ---

        You are a senior software engineer specializing in code reviews.
        Focus on code quality, security, and maintainability.
      '';
      documentation = ''
        ---
        name: documentation
        description: Documentation writing assistant
        model: claude-3-5-sonnet-20241022
        tools: Read, Write, Edit
        ---

        You are a technical writer who creates clear, comprehensive documentation.
        Focus on user-friendly explanations and examples.
      '';
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
