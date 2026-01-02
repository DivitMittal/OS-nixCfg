{pkgs, ...}: let
  pnpmCommand = "${pkgs.pnpm}/bin/pnpm";
in {
  programs.github-copilot.mcpServers = {
    ## modelcontextprotocol
    filesystem = {
      type = "local";
      command = pnpmCommand;
      args = ["dlx" "@modelcontextprotocol/server-filesystem"];
    };
    sequential-thinking = {
      type = "local";
      command = pnpmCommand;
      args = ["dlx" "@modelcontextprotocol/server-sequential-thinking"];
    };
    memory = {
      type = "local";
      command = pnpmCommand;
      args = ["dlx" "@modelcontextprotocol/server-memory"];
    };
    ## Third-party
    deepwiki = {
      type = "http";
      url = "https://mcp.deepwiki.com/mcp";
    };
    # octocode = {
    #   type = "local";
    #   command = pnpmCommand;
    #   args = ["dlx" "octocode-mcp@latest"];
    # };
    exa = {
      type = "local";
      command = pnpmCommand;
      args = ["dlx" "exa-mcp-server"];
    };
  };
}
