{pkgs, ...}: let
  pnpmCommand = "${pkgs.pnpm}/bin/pnpm";
  # uvCommand = "${pkgs.uv}/bin/uvx";
in {
  programs.crush.settings.mcp = {
    ## modelcontextprotocol
    filesystem = {
      type = "stdio";
      command = pnpmCommand;
      args = ["dlx" "@modelcontextprotocol/server-filesystem"];
    };
    sequential-thinking = {
      type = "stdio";
      command = pnpmCommand;
      args = ["dlx" "@modelcontextprotocol/server-sequential-thinking"];
    };
    memory = {
      type = "stdio";
      command = pnpmCommand;
      args = ["dlx" "@modelcontextprotocol/server-memory"];
    };
    ## Microsoft
    # playwright = {
    #   type = "stdio";
    #   command = pnpmCommand;
    #   args = ["dlx" "@playwright/mcp"];
    # };
    # markitdown = {
    #   type = "stdio";
    #   command = uvCommand;
    #   args = ["markitdown-mcp"];
    # };
    ## third-party
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
