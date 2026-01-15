_: {
  programs.codex.settings = {
    # ===== Core Model Settings =====
    model = "gpt-5.2-codex";

    # GPT-5 specific settings
    model_reasoning_effort = "medium";
    model_reasoning_summary = "detailed";
    model_verbosity = "medium";

    # ===== TUI =====
    tui = {
      notifications = true;
      animations = true;
    };
    check_for_update_on_startup = false;
    cli_auth_credentials_store = "file";
    feedback.enabled = false;
    project_doc_fallback_filenames = ["CLAUDE.md"];
    startup_timeout_sec = "60";

    # ===== Features =====
    features = {
      shell_snapshot = true;
      web_search_request = true;
      tui2 = true;
    };

    # ===== Profiles =====
    profile = "default";

    profiles = {
      default = {
        model = "gpt-5.2-codex";
        approval_policy = "on-request";
        sandbox_mode = "workspace-write";
      };

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

    # ===== Security & Approvals =====
    approval_policy = "on-request";
    sandbox_mode = "workspace-write";

    sandbox_workspace_write = {
      network_access = true;
      exclude_tmpdir_env_var = false;
      exclude_slash_tmp = false;
    };
  };
}
