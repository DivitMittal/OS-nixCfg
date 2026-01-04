_: {
  programs.github-copilot.settings.permissions = {
    allow = [];
    defaultMode = "acceptEdits";
    deny = [
      "WebFetch"
    ];
  };
}
