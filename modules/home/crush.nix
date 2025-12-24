{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.crush;

  jsonFormat = pkgs.formats.json {};

  lspServerType = lib.types.submodule {
    options = {
      command = lib.mkOption {
        type = lib.types.str;
        description = "The LSP server command to execute.";
      };
      args = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Arguments to pass to the LSP server command.";
      };
    };
  };

  mcpServerType = lib.types.submodule {
    options = {
      type = lib.mkOption {
        type = lib.types.enum ["stdio"];
        default = "stdio";
        description = "The type of MCP server connection.";
      };
      command = lib.mkOption {
        type = lib.types.str;
        description = "The MCP server command to execute.";
      };
      args = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Arguments to pass to the MCP server command.";
      };
    };
  };

  permissionsType = lib.types.submodule {
    options = {
      allowed_tools = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "List of tools that are allowed to be used.";
      };
    };
  };
in {
  options.programs.crush = {
    enable = lib.mkEnableOption "crush coding assistant";
    package = lib.mkPackageOption pkgs "crush" {nullable = true;};

    settings = lib.mkOption {
      inherit (jsonFormat) type;
      default = {};
      description = ''
        Raw JSON configuration for crush.
        This will be merged with the structured configuration options below.
      '';
    };

    schema = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = "https://charm.land/crush.json";
      description = "JSON schema URL for crush configuration.";
    };

    lsp = lib.mkOption {
      type = lib.types.attrsOf lspServerType;
      default = {};
      example = lib.literalExpression ''
        {
          go = {
            command = "gopls";
          };
          typescript = {
            command = "typescript-language-server";
            args = ["--stdio"];
          };
          nix = {
            command = "nixd";
          };
        }
      '';
      description = ''
        LSP server configurations by language.
        Each attribute name represents a language, and the value specifies the LSP server command and arguments.
      '';
    };

    mcp = lib.mkOption {
      type = lib.types.attrsOf mcpServerType;
      default = {};
      example = lib.literalExpression ''
        {
          filesystem = {
            type = "stdio";
            command = "npx";
            args = ["-y" "@modelcontextprotocol/server-filesystem"];
          };
          memory = {
            type = "stdio";
            command = "npx";
            args = ["-y" "@modelcontextprotocol/server-memory"];
          };
        }
      '';
      description = ''
        Model Context Protocol (MCP) server configurations.
        Each attribute name represents an MCP server, and the value specifies the connection type, command, and arguments.
      '';
    };

    permissions = lib.mkOption {
      type = lib.types.nullOr permissionsType;
      default = null;
      example = lib.literalExpression ''
        {
          allowed_tools = [
            "view"
            "ls"
            "grep"
            "edit"
            "mcp_context7_get-library-doc"
          ];
        }
      '';
      description = ''
        Permission settings for crush.
        Defines which tools are allowed to be used by the assistant.
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
        Custom commands for crush.
        Each command is a string containing YAML frontmatter and markdown content.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home =
      {
        packages = lib.mkIf (cfg.package != null) [cfg.package];

        file."${config.xdg.configHome}/crush/crush.json" = {
          source = jsonFormat.generate "crush-config.json" (
            lib.recursiveUpdate cfg.settings (
              lib.filterAttrs (_: v: v != null && v != {}) {
                "$schema" = cfg.schema;
                inherit (cfg) lsp;
                inherit (cfg) mcp;
                inherit (cfg) permissions;
              }
            )
          );
        };
      }
      // lib.optionalAttrs (cfg.commands != {}) {
        # Custom commands at ~/.config/crush/commands/
        file = lib.mapAttrs' (name: content:
          lib.nameValuePair "${config.xdg.configHome}/crush/commands/${name}.md" {
            text = content;
          })
        cfg.commands;
      };
  };
}
