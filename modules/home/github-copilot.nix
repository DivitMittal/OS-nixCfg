{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.github-copilot;

  jsonFormat = pkgs.formats.json {};

  mcpServerType = lib.types.submodule {
    options = {
      type = lib.mkOption {
        type = lib.types.enum ["local" "http"];
        default = "local";
        description = "The type of MCP server connection.";
      };
      command = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "The MCP server command to execute (for local type).";
      };
      args = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Arguments to pass to the MCP server command.";
      };
      url = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "URL for HTTP-based MCP servers.";
      };
      tools = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = ["*"];
        description = ''List of tool names to expose. Use ["*"] to expose all tools.'';
      };
    };
  };

  permissionsType = lib.types.submodule {
    options = {
      allow = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "List of tools/operations that are allowed.";
      };
      ask = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "List of tools/operations that require user confirmation.";
      };
      deny = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "List of tools/operations that are denied.";
      };
      defaultMode = lib.mkOption {
        type = lib.types.str;
        default = "acceptEdits";
        description = "Default permission mode.";
      };
    };
  };

  settingsType = lib.types.submodule {
    options = {
      permissions = lib.mkOption {
        type = lib.types.nullOr permissionsType;
        default = null;
        description = "Permission settings for GitHub Copilot CLI.";
      };
      theme = lib.mkOption {
        type = lib.types.str;
        default = "dark";
        description = "UI theme for GitHub Copilot CLI.";
      };
    };
  };
in {
  options.programs.github-copilot = {
    enable = lib.mkEnableOption "GitHub Copilot CLI with MCP support";
    package = lib.mkPackageOption pkgs "copilot-cli" {nullable = true;};

    mcpServers = lib.mkOption {
      type = lib.types.attrsOf mcpServerType;
      default = {};
      example = lib.literalExpression ''
        {
          filesystem = {
            type = "local";
            command = "pnpm";
            args = ["dlx" "@modelcontextprotocol/server-filesystem"];
            tools = ["*"];
          };
          memory = {
            type = "local";
            command = "pnpm";
            args = ["dlx" "@modelcontextprotocol/server-memory"];
            tools = ["*"];
          };
          deepwiki = {
            type = "http";
            url = "https://mcp.deepwiki.com/mcp";
            tools = ["*"];
          };
        }
      '';
      description = ''
        Model Context Protocol (MCP) server configurations for GitHub Copilot CLI.
        Each attribute name represents an MCP server, and the value specifies the connection details.
      '';
    };

    settings = lib.mkOption {
      type = settingsType;
      default = {};
      description = ''
        Settings for GitHub Copilot CLI including permissions and UI configuration.
      '';
    };

    extraConfig = lib.mkOption {
      inherit (jsonFormat) type;
      default = {};
      description = ''
        Additional raw JSON configuration that will be merged with the structured options.
      '';
    };

    commands = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      example = lib.literalExpression ''
        {
          commit = '''
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
          ''';
        }
      '';
      description = ''
        Custom commands for GitHub Copilot CLI.
        Each command is a string containing YAML frontmatter and markdown content.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home =
      {
        packages = lib.mkIf (cfg.package != null) [cfg.package];

        # MCP servers configuration at ~/.config/.copilot/mcp-config.json
        file."${config.xdg.configHome}/.copilot/mcp-config.json" = lib.mkIf (cfg.mcpServers != {}) {
          source = jsonFormat.generate "copilot-mcp-config.json" {
            mcpServers = lib.mapAttrs (_: server: lib.filterAttrs (_: v: v != null) server) cfg.mcpServers;
          };
        };

        # General settings at ~/.config/.copilot/config.json
        file."${config.xdg.configHome}/.copilot/config.json" = lib.mkIf (cfg.settings != {} || cfg.extraConfig != {}) {
          source = jsonFormat.generate "copilot-config.json" (lib.recursiveUpdate cfg.extraConfig cfg.settings);
        };
      }
      // lib.optionalAttrs (cfg.commands != {}) {
        # Custom commands at ~/.config/.copilot/commands/
        file = lib.mapAttrs' (name: content:
          lib.nameValuePair "${config.xdg.configHome}/.copilot/commands/${name}.md" {
            text = content;
          })
        cfg.commands;
      };
  };
}
