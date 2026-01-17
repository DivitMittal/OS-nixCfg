{pkgs, ...}: let
  pnpmCommand = "${pkgs.pnpm}/bin/pnpm";
in {
  programs.github-copilot.mcpServers = {
    sequential-thinking = {
      type = "local";
      command = pnpmCommand;
      args = ["dlx" "@modelcontextprotocol/server-sequential-thinking"];
    };
    deepwiki = {
      type = "http";
      url = "https://mcp.deepwiki.com/mcp";
    };
    exa = {
      type = "local";
      command = pnpmCommand;
      args = ["dlx" "exa-mcp-server"];
    };
  };
}
