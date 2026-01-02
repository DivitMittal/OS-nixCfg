_: {
  programs.github-copilot.settings.permissions = {
    allow = [
      ## Octocode MCP
      "mcp__octocode__githubViewRepoStructure"
      "mcp__octocode__githubGetFileContent"
      "mcp__octocode__githubSearchCode"
    ];
    defaultMode = "acceptEdits";
    deny = [
      "WebFetch"
    ];
  };
}
