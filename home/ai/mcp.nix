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
      sequential-thinking = {
        command = "${pkgs.pnpm}/bin/pnpm";
        args = ["dlx" "@modelcontextprotocol/server-sequential-thinking"];
      };
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
      # filesystem = {
      #   command = "${pkgs.pnpm}/bin/pnpm";
      #   args = ["dlx" "@modelcontextprotocol/server-filesystem"];
      # };
      # memory = {
      #   command = "${pkgs.pnpm}/bin/pnpm";
      #   args = ["dlx" "@modelcontextprotocol/server-memory"];
      # };
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
