{pkgs, ...}: let
  pnpmCommand = "${pkgs.pnpm}/bin/pnpm";
  # uvCommand = "${pkgs.uv}/bin/uvx";
in {
  programs.gemini-cli.settings.mcpServers = {
    ## modelcontextprotocol
    filesystem = {
      command = pnpmCommand;
      args = ["dlx" "@modelcontextprotocol/server-filesystem"];
    };
    sequential-thinking = {
      command = pnpmCommand;
      args = ["dlx" "@modelcontextprotocol/server-sequential-thinking"];
    };
    memory = {
      command = pnpmCommand;
      args = ["dlx" "@modelcontextprotocol/server-memory"];
    };
    ## microsoft
    # playwright = {
    #   command = "npx";
    #   args = ["-y" "@playwright/mcp"];
    # };
    # markitdown = {
    #   command = uvCommand;
    #   args = ["markitdown-mcp"];
    # };
    ## third-party
    deepwiki = {
      trust = true;
      httpUrl = "https://mcp.deepwiki.com/mcp";
    };
    octocode = {
      command = pnpmCommand;
      args = ["dlx" "octocode-mcp@latest"];
    };
    # ddg = {
    #   command = pnpmCommand;
    #   args = ["dlx" "duckduckgo-mcp-server"];
    # };
  };
}
