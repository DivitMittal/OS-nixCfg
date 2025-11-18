{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit (pkgs.custom) gowa;
  };

  # Central MCP (Model Context Protocol) server configuration
  # Shared across multiple AI tools that support enableMcpIntegration
  programs.mcp = {
    enable = true;
    servers = {
      # Official Model Context Protocol servers
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

      # Commented out servers (uncomment as needed)
      # playwright = {
      #   command = "${pkgs.pnpm}/bin/pnpm";
      #   args = ["dlx" "@playwright/mcp"];
      # };
      # markitdown = {
      #   command = "${pkgs.uv}/bin/uvx";
      #   args = ["markitdown-mcp"];
      # };
    };
  };
}
