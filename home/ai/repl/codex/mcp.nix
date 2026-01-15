{pkgs, ...}: let
  pnpmCommand = "${pkgs.pnpm}/bin/pnpm";
in {
  programs.codex.settings.mcp_servers = {
    sequential-thinking = {
      type = "stdio";
      command = pnpmCommand;
      args = ["dlx" "@modelcontextprotocol/server-sequential-thinking"];
    };
    deepwiki = {
      type = "http";
      url = "https://mcp.deepwiki.com/mcp";
    };
    octocode = {
      type = "stdio";
      command = pnpmCommand;
      args = ["dlx" "octocode-mcp@latest"];
    };
    exa = {
      type = "stdio";
      command = pnpmCommand;
      args = ["dlx" "exa-mcp-server"];
    };
  };
}
