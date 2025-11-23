{
  lib,
  pkgs,
  ...
}: {
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
