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
      deepwiki = {
        url = "https://mcp.deepwiki.com/mcp";
      };
      octocode = {
        command = "${pkgs.pnpm}/bin/pnpm";
        args = ["dlx" "octocode-mcp@latest"];
      };
      exa = {
        command = "${pkgs.pnpm}/bin/pnpm";
        args = ["dlx" "exa-mcp-server"];
      };
      ### Capabilities already enabled in modern repl environments
      # filesystem = {
      #   command = "${pkgs.pnpm}/bin/pnpm";
      #   args = ["dlx" "@modelcontextprotocol/server-filesystem"];
      # };
      ## ultrathink
      # sequential-thinking = {
      #   command = "${pkgs.pnpm}/bin/pnpm";
      #   args = ["dlx" "@modelcontextprotocol/server-sequential-thinking"];
      # };
      ## beads
      # memory = {
      #   command = "${pkgs.pnpm}/bin/pnpm";
      #   args = ["dlx" "@modelcontextprotocol/server-memory"];
      # };
      ## Capabilities that require domain-specific setup to save context
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
