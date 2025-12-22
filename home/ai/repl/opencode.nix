{
  lib,
  pkgs,
  ...
}: let
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
  home.packages = lib.attrsets.attrValues {
    inherit (pkgs.custom) gowa;
  };

  programs.mcp = {
    enable = true;
    servers = {
      filesystem = {
        command = "${pkgs.pnpm}/bin/pnpm";
        args = ["dlx" "@modelcontextprotocol/server-filesystem"];
      };
      sequential-thinking = {
        command = "${pkgs.pnpm}/bin/pnpm";
        args = ["dlx" "@modelcontextprotocol/server-sequential-thinking"];
      };
      memory = {
        command = "${pkgs.pnpm}/bin/pnpm";
        args = ["dlx" "@modelcontextprotocol/server-memory"];
      };

      # Third-party MCP servers
      deepwiki = {
        url = "https://mcp.deepwiki.com/mcp";
      };
      octocode = {
        command = "${pkgs.pnpm}/bin/pnpm";
        args = ["dlx" "octocode-mcp@latest"];
      };
      ddg = {
        command = "${pkgs.pnpm}/bin/pnpm";
        args = ["dlx" "duckduckgo-mcp-server"];
      };
    };
  };

  programs.opencode = {
    enable = true;
    package = pkgs.ai.opencode;
    # Use central MCP configuration from programs.mcp
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
      instructions = ["CLAUDE.md"];

      plugin = [
        "oh-my-opencode"
        "opencode-antigravity-auth@1.1.2"
      ];

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
        nix = {
          command = ["nixd"];
          extensions = ["nix"];
        };
      };

      formatter = {
        nix = {
          command = ["alejandra"];
          extensions = ["nix"];
        };
      };
    };
  };

  # Generate oh-my-opencode.json from Nix attrset using XDG
  xdg.configFile."opencode/oh-my-opencode.json".text = builtins.toJSON ohMyOpencodeConfig;
}
