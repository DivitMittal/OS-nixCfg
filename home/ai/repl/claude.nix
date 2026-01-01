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

    ## Agents - Specialized AI assistants with isolated context windows
    ## Format: name = "markdown content with YAML frontmatter";
    ## Location: ~/.claude/agents/<name>.md
    agents = {
      nix-expert = ''
        ---
        name: nix-expert
        description: MUST BE USED for Nix/NixOS configuration, flakes, and derivations
        model: sonnet
        tools: Read, Write, Edit, Grep, Glob, Bash
        ---

        You are a Nix expert specializing in:
        - NixOS system configuration
        - Home Manager modules
        - Nix flakes and derivations
        - nix-darwin for macOS

        ## Guidelines
        - Always use `lib.mkOption` with proper types for module options
        - Prefer `lib.mkIf` and `lib.mkMerge` for conditional configs
        - Use `pkgs.writeShellScriptBin` for simple shell wrappers
        - Follow the repository's existing patterns in `modules/` and `home/`
        - Run `nix fmt` after any Nix file changes
        - Test with `nix flake check` before committing

        ## Common Patterns
        - Use `lib.attrsets.attrValues` for package lists
        - Use `scanPaths` from `lib/custom.nix` for auto-imports
        - Keep platform-specific code in appropriate subdirs (darwin/, nixos/)
      '';

      code-reviewer = ''
        ---
        name: code-reviewer
        description: Use PROACTIVELY for code reviews and PR analysis
        model: sonnet
        tools: Read, Grep, Glob
        ---

        You are a senior code reviewer. Analyze code for:

        ## Review Checklist
        1. **Correctness**: Logic errors, edge cases, error handling
        2. **Security**: Input validation, secrets exposure, injection risks
        3. **Performance**: Unnecessary allocations, N+1 queries, blocking ops
        4. **Maintainability**: Naming, complexity, documentation
        5. **Testing**: Coverage gaps, test quality

        ## Output Format
        Provide structured feedback:
        - 🔴 **Critical**: Must fix before merge
        - 🟡 **Warning**: Should address
        - 🟢 **Suggestion**: Nice to have
        - 💡 **Note**: Informational

        Be specific with line numbers and concrete suggestions.
      '';

      security-auditor = ''
        ---
        name: security-auditor
        description: MUST BE USED for security reviews and vulnerability assessment
        model: opus
        tools: Read, Grep, Glob
        ---

        You are a security auditor. Analyze code for vulnerabilities:

        ## Security Checklist
        - **Injection**: SQL, command, path traversal
        - **Authentication**: Session management, token handling
        - **Authorization**: Access control, privilege escalation
        - **Data Protection**: Encryption, secrets management
        - **Dependencies**: Known CVEs, outdated packages

        ## For Nix Configs
        - Check for hardcoded secrets (use agenix/ragenix)
        - Verify permission settings
        - Audit exposed services and ports
        - Review systemd service sandboxing

        Provide severity ratings (Critical/High/Medium/Low) with remediation steps.
      '';

      test-writer = ''
        ---
        name: test-writer
        description: Use when writing or improving tests
        model: sonnet
        tools: Read, Write, Edit, Grep, Bash
        ---

        You are a test engineering expert. Write comprehensive tests:

        ## Testing Principles
        - **Arrange-Act-Assert** pattern
        - One assertion per test when practical
        - Descriptive test names explaining the scenario
        - Cover happy path, edge cases, and error conditions

        ## Test Types
        - Unit tests: Isolated, fast, mock dependencies
        - Integration tests: Real dependencies, slower
        - E2E tests: Full system, critical paths only

        ## Coverage Goals
        - Focus on business logic and complex functions
        - Don't test trivial getters/setters
        - Prioritize code paths with high risk
      '';
    };
  };

  ## Skills - Modular knowledge packages with progressive disclosure
  ## Location: ~/.claude/skills/<name>/SKILL.md
  ## Note: Skills are not a built-in home-manager option, so we use xdg.configFile
  home.file = {
    ".claude/skills/nix-flakes/SKILL.md".text = ''
      ---
      name: nix-flakes
      description: Deep knowledge of Nix flakes. Use when working with flake.nix, inputs, or outputs.
      ---

      # Nix Flakes Expertise

      ## Flake Structure
      ```nix
      {
        inputs = {
          nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
          # Lock to specific commit for reproducibility
          home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
          };
        };

        outputs = { self, nixpkgs, ... }@inputs: {
          # NixOS configurations
          nixosConfigurations.hostname = nixpkgs.lib.nixosSystem { ... };
          # Darwin configurations
          darwinConfigurations.hostname = darwin.lib.darwinSystem { ... };
          # Home Manager standalone
          homeConfigurations.user = home-manager.lib.homeManagerConfiguration { ... };
          # Packages
          packages.x86_64-linux.default = ...;
          # Dev shells
          devShells.x86_64-linux.default = ...;
        };
      }
      ```

      ## Common Commands
      - `nix flake check` - Validate flake
      - `nix flake update` - Update all inputs
      - `nix flake lock --update-input nixpkgs` - Update single input
      - `nix build .#package` - Build specific output
      - `nix develop` - Enter dev shell

      ## Best Practices
      - Use `follows` to deduplicate nixpkgs instances
      - Pin inputs with `flake.lock`
      - Use `flake-parts` for large flakes
      - Keep outputs organized with let bindings
    '';

    ".claude/skills/home-manager-modules/SKILL.md".text = ''
      ---
      name: home-manager-modules
      description: Home Manager module patterns. Use when creating or modifying home-manager configs.
      ---

      # Home Manager Module Patterns

      ## Module Structure
      ```nix
      { config, lib, pkgs, ... }:
      let
        cfg = config.programs.myProgram;
      in {
        options.programs.myProgram = {
          enable = lib.mkEnableOption "myProgram";

          package = lib.mkPackageOption pkgs "myProgram" {};

          settings = lib.mkOption {
            type = lib.types.attrsOf lib.types.anything;
            default = {};
            description = "Configuration options";
          };
        };

        config = lib.mkIf cfg.enable {
          home.packages = [ cfg.package ];

          xdg.configFile."myProgram/config.json".source =
            pkgs.formats.json {}.generate "config.json" cfg.settings;
        };
      }
      ```

      ## Common Patterns
      - Use `xdg.configFile` for dotfiles
      - Use `home.file` for non-XDG locations
      - Use `pkgs.formats.*` for config generation
      - Prefer `lib.mkPackageOption` over manual package options
      - Use `lib.mkMerge` for conditional config sections
    '';

    ".claude/skills/conventional-commits/SKILL.md".text = ''
      ---
      name: conventional-commits
      description: Conventional Commits format. Use when creating commit messages.
      ---

      # Conventional Commits

      ## Format
      ```
      <type>(<scope>): <description>

      [optional body]

      [optional footer(s)]
      ```

      ## Types
      - `feat`: New feature
      - `fix`: Bug fix
      - `docs`: Documentation only
      - `style`: Formatting, no code change
      - `refactor`: Code change, no feature/fix
      - `perf`: Performance improvement
      - `test`: Adding/fixing tests
      - `chore`: Build, tools, deps
      - `ci`: CI configuration

      ## Scope Examples (for this repo)
      - `home`: Home manager configs
      - `darwin`: macOS-specific
      - `nixos`: NixOS-specific
      - `flake`: Flake inputs/outputs
      - `module`: Custom modules
      - `pkg`: Custom packages

      ## Examples
      - `feat(home): add starship prompt configuration`
      - `fix(darwin): resolve homebrew cask conflicts`
      - `refactor(module): simplify claude-code options`
      - `chore(flake): update nixpkgs input`
    '';
  };
}
