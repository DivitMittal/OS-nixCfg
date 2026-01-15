{pkgs, ...}: let
  pnpmCommand = "${pkgs.pnpm}/bin/pnpm";
  # uvCommand = "${pkgs.uv}/bin/uvx";
in {
  programs.gemini-cli.settings.mcpServers = {
    sequential-thinking = {
      command = pnpmCommand;
      args = ["dlx" "@modelcontextprotocol/server-sequential-thinking"];
    };
    deepwiki = {
      trust = true;
      httpUrl = "https://mcp.deepwiki.com/mcp";
    };
    octocode = {
      command = pnpmCommand;
      args = ["dlx" "octocode-mcp@latest"];
    };
  };
}
