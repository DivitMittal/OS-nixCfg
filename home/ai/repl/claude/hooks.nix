_: {
  programs.claude-code.settings.hooks = {
    ## Security checks before tool execution
    PreToolUse = [
      # Check for dangerous rm commands in Bash
      {
        matcher = "Bash";
        hooks = [
          {
            type = "command";
            command = ''
              #!/usr/bin/env bash
              set -euo pipefail

              # Parse input
              tool_input=$(jq -r '.tool_input // empty' <<< "$CLAUDE_TOOL_INPUT" 2>/dev/null || echo "{}")
              command=$(jq -r '.command // empty' <<< "$tool_input" 2>/dev/null || echo "")
              normalized=$(echo "$command" | tr '[:upper:]' '[:lower:]' | tr -s ' ')

              # Detect dangerous rm patterns
              if [[ "$normalized" =~ rm[[:space:]].*-[a-z]*r[a-z]*f ]] || \
                 [[ "$normalized" =~ rm[[:space:]].*-[a-z]*f[a-z]*r ]] || \
                 [[ "$normalized" =~ rm[[:space:]].*--recursive.*--force ]] || \
                 [[ "$normalized" =~ rm[[:space:]].*--force.*--recursive ]]; then

                # Check for dangerous paths
                if [[ "$normalized" =~ (^|[[:space:]])(/\*?|~/?|\$HOME|\.\.|\*|\.)[[:space:]]* ]]; then
                  echo "BLOCKED: Dangerous rm command detected and prevented" >&2
                  exit 2
                fi
              fi

              # Check for .env file access in bash commands
              if [[ "$command" =~ \.env[^.] ]] && [[ ! "$command" =~ \.env\.sample ]]; then
                echo "BLOCKED: Access to .env files containing sensitive data is prohibited" >&2
                echo "Use .env.sample for template files instead" >&2
                exit 2
              fi

              exit 0
            '';
          }
        ];
      }

      # Check for .env file access in file operations
      {
        matcher = "Read|Edit|Write";
        hooks = [
          {
            type = "command";
            command = ''
              #!/usr/bin/env bash
              set -euo pipefail

              # Parse input
              tool_input=$(jq -r '.tool_input // empty' <<< "$CLAUDE_TOOL_INPUT" 2>/dev/null || echo "{}")
              file_path=$(jq -r '.file_path // empty' <<< "$tool_input" 2>/dev/null || echo "")

              # Block .env files (but allow .env.sample)
              if [[ "$file_path" == *.env && "$file_path" != *.env.sample ]]; then
                echo "BLOCKED: Access to .env files containing sensitive data is prohibited" >&2
                echo "Use .env.sample for template files instead" >&2
                exit 2
              fi

              exit 0
            '';
          }
        ];
      }
    ];

    ## Auto-format Nix files after edits
    PostToolUse = [
      {
        matcher = "Edit|Write";
        hooks = [
          {
            type = "command";
            command = ''
              #!/usr/bin/env bash
              set -euo pipefail

              # Get the file path
              file=$(jq -r '.tool_input.file_path // .file_path // empty' <<< "$CLAUDE_TOOL_INPUT" 2>/dev/null || echo "")

              # Auto-format Nix files
              if [[ "$file" == *.nix ]]; then
                nix fmt "$file" 2>/dev/null || true
              fi
            '';
          }
        ];
      }
    ];

    ## Notification on session stop
    Stop = [
      {
        hooks = [
          {
            type = "command";
            command = ''
              #!/usr/bin/env bash
              osascript -e 'display notification "AI task complete, awaiting response" with title "AI Assistant"' 2>/dev/null || true
            '';
          }
        ];
      }
    ];
  };
}
