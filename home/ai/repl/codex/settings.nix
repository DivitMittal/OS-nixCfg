_: {
  programs.codex.settings = {
    # ===== Core Model Settings =====
    model = "gpt-5.2-codex";
    model_provider = "openai";
    model_context_window = 128000;
    model_auto_compact_token_limit = 100000;
    tool_output_token_limit = 10000;

    # GPT-5 specific settings
    model_reasoning_effort = "medium";
    model_reasoning_summary = "auto";
    model_verbosity = "medium";

    # ===== Security & Approvals =====
    approval_policy = "on-request";
    sandbox_mode = "workspace-write";

    sandbox_workspace_write = {
      network_access = true;
      exclude_tmpdir_env_var = false;
      exclude_slash_tmp = false;
    };

    # ===== History =====
    history = {
      persistence = "save-all";
      max_bytes = 10485760; # 10MB
    };

    # ===== TUI =====
    tui = {
      notifications = true;
      animations = true;
    };

    # ===== Features =====
    features = {
      shell_snapshot = true;
      web_search_request = true;
    };

    # ===== Profiles =====
    profile = "default";

    profiles = {
      conservative = {
        model = "gpt-5.2-codex";
        approval_policy = "untrusted";
        sandbox_mode = "read-only";
      };

      power = {
        model = "gpt-5.2-codex";
        model_reasoning_effort = "xhigh";
        approval_policy = "on-failure";
        sandbox_mode = "workspace-write";

        sandbox_workspace_write = {
          network_access = true;
        };
      };
    };
  };
}
