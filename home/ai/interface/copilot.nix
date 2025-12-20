{
  pkgs,
  inputs,
  hostPlatform,
  ...
}: {
  programs.github-copilot = let
    pnpmCommand = "${pkgs.pnpm}/bin/pnpm";
  in {
    enable = true;
    package = inputs.nix-ai-tools.packages.${hostPlatform.system}.copilot-cli;

    mcpServers = {
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
      octocode = {
        type = "local";
        command = pnpmCommand;
        args = ["dlx" "octocode-mcp@latest"];
      };
      ddg = {
        type = "local";
        command = pnpmCommand;
        args = ["dlx" "duckduckgo-mcp-server"];
      };
    };

    settings = {
      permissions = {
        allow = [
          ## Filesystem MCP
          "mcp__filesystem__list_directory"
          "mcp__filesystem__edit_file"
          "mcp__filesystem__write_file"
          "mcp__filesystem__read_text_file"
          "mcp__filesystem__read_multiple_files"
          "mcp__filesystem__create_directory"
          "mcp__filesystem__directory_tree"

          ## Memory MCP
          "mcp__memory__store"
          "mcp__memory__retrieve"
          "mcp__memory__search"

          ## Octocode MCP
          "mcp__octocode__githubViewRepoStructure"
          "mcp__octocode__githubGetFileContent"
          "mcp__octocode__githubSearchCode"

          ## DuckDuckGo MCP
          "mcp__ddg__search"
        ];
        defaultMode = "acceptEdits";
        deny = [
          "WebFetch"
        ];
      };
      theme = "dark";
    };
  };
}
