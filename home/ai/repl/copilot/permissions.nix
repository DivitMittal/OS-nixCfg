_: {
  programs.github-copilot.settings.permissions = {
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
}
