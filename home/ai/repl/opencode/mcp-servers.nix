{pkgs, ...}: {
  programs.opencode.settings.mcp = {
    filesystem = {
      type = "local";
      command = ["${pkgs.pnpm}/bin/pnpm" "dlx" "@modelcontextprotocol/server-filesystem"];
      enabled = true;
    };
    sequential-thinking = {
      type = "local";
      command = ["${pkgs.pnpm}/bin/pnpm" "dlx" "@modelcontextprotocol/server-sequential-thinking"];
      enabled = true;
    };
    memory = {
      type = "local";
      command = ["${pkgs.pnpm}/bin/pnpm" "dlx" "@modelcontextprotocol/server-memory"];
      enabled = true;
    };

    ## Third-party MCP servers
    octocode = {
      type = "local";
      command = ["${pkgs.pnpm}/bin/pnpm" "dlx" "octocode-mcp@latest"];
      enabled = true;
    };
    ## Inherit support in oh-my-opencode via context7 & websearch MCPs
    # deepwiki = {
    #   url = "https://mcp.deepwiki.com/mcp";
    # };
    # ddg = {
    #   type = "local";
    #   command = ["${pkgs.pnpm}/bin/pnpm" "dlx" "duckduckgo-mcp-server"];
    #   enabled = true;
    # };
  };
}
