{pkgs, ...}: let
  pnpmCommand = "${pkgs.pnpm}/bin/pnpm";
in {
  programs.claude-code.mcpServers = {
    deepwiki = {
      type = "http";
      url = "https://mcp.deepwiki.com/mcp";
    };
    octocode = {
      type = "stdio";
      command = pnpmCommand;
      args = ["dlx" "octocode-mcp@latest"];
    };
  };
}
