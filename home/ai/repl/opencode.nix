{pkgs, ...}: let
  ohMyOpencodeConfig = {
    "$schema" = "https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/master/assets/oh-my-opencode.schema.json";
    google_auth = false;
    agents = {
      oracle = {
        model = "anthropic/claude-opus-4-5";
      };
      frontend-ui-ux-engineer = {
        model = "google/gemini-3-pro-high";
      };
      document-writer = {
        model = "google/gemini-3-flash";
      };
      multimodal-looker = {
        model = "google/gemini-2.5-flash";
      };
    };
  };
in {
  programs.opencode = {
    enable = true;
    package = pkgs.writeShellScriptBin "opencode" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx opencode-ai "$@"
    '';
    # package = pkgs.ai.opencode;
    enableMcpIntegration = false;

    rules = ''
      ## External File Loading

      CRITICAL: When you encounter a file reference (e.g., @rules/general.md), use your Read tool to load it on a need-to-know basis. They're relevant to the SPECIFIC task at hand.

      Instructions:

      - Do NOT preemptively load all references - use lazy loading based on actual need
      - When loaded, treat content as mandatory instructions that override defaults
      - Follow references recursively when needed
    '';

    settings = {
      autoupdate = false;
      autoshare = false;

      theme = "system";

      plugin = [
        "oh-my-opencode"
        "opencode-antigravity-auth@1.1.2"
      ];

      mcp = {
        filesystem = {
          type = "local";
          command = ["${pkgs.pnpm}/bin/pnpm" "dlx" "@modelcontextprotocol/server-filesystem"];
          enabled = true;
        };
        sequential-thinking = {
          type = "local";
          command = ["${pkgs.pnpm}/bin/pnpm" "dlx" "@modelcontextprotocol/server-sequential-thinking"];
          enabled = true;
        };
        memory = {
          type = "local";
          command = ["${pkgs.pnpm}/bin/pnpm" "dlx" "@modelcontextprotocol/server-memory"];
          enabled = true;
        };

        ## Third-party MCP servers
        octocode = {
          type = "local";
          command = ["${pkgs.pnpm}/bin/pnpm" "dlx" "octocode-mcp@latest"];
          enabled = true;
        };
        ## Inherit support in oh-my-opencode via context7 & websearch MCPs
        # deepwiki = {
        #   url = "https://mcp.deepwiki.com/mcp";
        # };
        # ddg = {
        #   type = "local";
        #   command = ["${pkgs.pnpm}/bin/pnpm" "dlx" "duckduckgo-mcp-server"];
        #   enabled = true;
        # };
      };

      provider = {
        google = {
          models = {
            gemini-3-pro-high = {
              name = "Gemini 3 Pro High (Antigravity)";
              limit = {
                context = 1048576;
                output = 65535;
              };
              modalities = {
                input = ["text" "image" "pdf"];
                output = ["text"];
              };
            };
            gemini-3-pro-medium = {
              name = "Gemini 3 Pro Medium (Antigravity)";
              limit = {
                context = 1048576;
                output = 65535;
              };
              modalities = {
                input = ["text" "image" "pdf"];
                output = ["text"];
              };
            };
            gemini-3-pro-low = {
              name = "Gemini 3 Pro Low (Antigravity)";
              limit = {
                context = 1048576;
                output = 65535;
              };
              modalities = {
                input = ["text" "image" "pdf"];
                output = ["text"];
              };
            };
            gemini-3-flash = {
              name = "Gemini 3 Flash (Antigravity)";
              limit = {
                context = 1048576;
                output = 65536;
              };
              modalities = {
                input = ["text" "image" "pdf"];
                output = ["text"];
              };
            };
            "gemini-2.5-flash" = {
              name = "Gemini 2.5 Flash (Antigravity)";
              limit = {
                context = 1048576;
                output = 8192;
              };
              modalities = {
                input = ["text" "image" "pdf"];
                output = ["text"];
              };
            };
            "gemini-2.5-flash-lite" = {
              name = "Gemini 2.5 Flash Lite (Antigravity)";
              limit = {
                context = 1048576;
                output = 8192;
              };
              modalities = {
                input = ["text" "image" "pdf"];
                output = ["text"];
              };
            };
            claude-sonnet-4-5 = {
              name = "Claude Sonnet 4.5 (Antigravity)";
              limit = {
                context = 200000;
                output = 64000;
              };
              modalities = {
                input = ["text" "image" "pdf"];
                output = ["text"];
              };
            };
            claude-sonnet-4-5-thinking = {
              name = "Claude Sonnet 4.5 Thinking (Antigravity)";
              limit = {
                context = 200000;
                output = 64000;
              };
              modalities = {
                input = ["text" "image" "pdf"];
                output = ["text"];
              };
            };
            claude-opus-4-5-thinking = {
              name = "Claude Opus 4.5 Thinking (Antigravity)";
              limit = {
                context = 200000;
                output = 64000;
              };
              modalities = {
                input = ["text" "image" "pdf"];
                output = ["text"];
              };
            };
            gpt-oss-120b-medium = {
              name = "GPT-OSS 120B Medium (Antigravity)";
              limit = {
                context = 131072;
                output = 32768;
              };
              modalities = {
                input = ["text" "image" "pdf"];
                output = ["text"];
              };
            };
          };
        };
      };

      lsp = {
        # Custom LSPs (not built-in to OpenCode)
        nix = {
          command = ["nixd"];
          extensions = [".nix"];
        };
        html = {
          command = ["vscode-html-language-server" "--stdio"];
          extensions = [".html" ".htm"];
        };
        css = {
          command = ["vscode-css-language-server" "--stdio"];
          extensions = [".css" ".scss" ".less"];
        };
        json = {
          command = ["vscode-json-language-server" "--stdio"];
          extensions = [".json" ".jsonc"];
        };
        svelte = {
          command = ["svelteserver" "--stdio"];
          extensions = [".svelte"];
        };
        emmet = {
          command = ["emmet-language-server" "--stdio"];
          extensions = [".html" ".css" ".jsx" ".tsx" ".vue"];
        };
        haskell = {
          command = ["haskell-language-server-wrapper" "--lsp"];
          extensions = [".hs" ".lhs"];
        };
        python = {
          command = ["pylsp"];
          extensions = [".py" ".pyi"];
        };
        lua = {
          command = ["lua-language-server"];
          extensions = [".lua"];
        };
        yaml = {
          command = ["yaml-language-server" "--stdio"];
          extensions = [".yaml" ".yml"];
        };
      };

      formatter = {
        nix = {
          command = ["alejandra"];
          extensions = [".nix"];
        };
        lua = {
          command = ["stylua" "-"];
          extensions = [".lua"];
        };
        c-cpp = {
          command = ["clang-format"];
          extensions = [".c" ".cpp" ".cc" ".cxx" ".h" ".hpp"];
        };
        web = {
          command = ["prettier" "--stdin-filepath" "file.ts"];
          extensions = [".html" ".css" ".js" ".jsx" ".ts" ".tsx" ".json" ".md" ".yaml" ".yml"];
        };
        python = {
          command = ["black" "-"];
          extensions = [".py"];
        };
        shell = {
          command = ["shfmt"];
          extensions = [".sh" ".bash"];
        };
        fish = {
          command = ["fish_indent"];
          extensions = [".fish"];
        };
        haskell = {
          command = ["ormolu"];
          extensions = [".hs" ".lhs"];
        };
        swift = {
          command = ["swift-format"];
          extensions = [".swift"];
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

  ## oh-my-opencode
  xdg.configFile."opencode/oh-my-opencode.json".text = builtins.toJSON ohMyOpencodeConfig;
}
