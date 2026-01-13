_: {
  programs.claude-code.settings = {
    enabledPlugins = {
      "ralph-wiggum@claude-plugins-official" = true;
      "glm-plan-usage@zai-coding-plugins" = true;
    };
  };
}
