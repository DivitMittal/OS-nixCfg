{
  inputs,
  hostPlatform,
  ...
}: {
  programs.opencode = {
    enable = true;
    package = inputs.nix-ai-tools.packages.${hostPlatform.system}.opencode;

    # Use central MCP configuration from programs.mcp
    enableMcpIntegration = true;

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

      # MCP servers now managed centrally via programs.mcp
      # Tool-specific overrides can still be added here if needed
    };
  };
}
