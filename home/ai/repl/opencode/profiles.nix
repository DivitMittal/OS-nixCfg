{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.programs.opencode;

  ## Base agents used across all profiles
  agentNames = [
    "Sisyphus"
    "Sisyphus-Junior"
    "Planner-Sisyphus"
    "oracle"
    "frontend-ui-ux-engineer"
    "document-writer"
    "multimodal-looker"
    "explore"
    "librarian"
  ];

  ## Agent role -> model mapping per profile
  profiles = {
    ## Pure Claude via Anthropic API
    claude = {
      Sisyphus = "anthropic/claude-opus-4-5";
      Sisyphus-Junior = "anthropic/claude-sonnet-4-5";
      Planner-Sisyphus = "anthropic/claude-sonnet-4-5";
      oracle = "anthropic/claude-opus-4-5";
      frontend-ui-ux-engineer = "anthropic/claude-sonnet-4-5";
      document-writer = "anthropic/claude-haiku-4-5";
      multimodal-looker = "anthropic/claude-sonnet-4-5";
      explore = "anthropic/claude-sonnet-4-5";
      librarian = "anthropic/claude-haiku-4-5";
    };

    ## OpenAI Codex models
    codex = {
      Sisyphus = "openai/gpt-5.1-codex-max";
      Sisyphus-Junior = "openai/gpt-5.1-codex-max";
      Planner-Sisyphus = "openai/gpt-5.1-codex-max";
      oracle = "openai/gpt-5.1-codex-max-high";
      frontend-ui-ux-engineer = "openai/gpt-5.1-codex-max";
      document-writer = "openai/gpt-5.1-codex-mini-high";
      multimodal-looker = "openai/gpt-5.1-codex-max";
      explore = "openai/gpt-5.1-codex-max";
      librarian = "openai/gpt-5.1-codex-mini-high";
    };

    ## Codex + GLM hybrid
    codexglm = {
      Sisyphus = "openai/gpt-5.1-codex-max";
      Sisyphus-Junior = "zai-coding-plan/glm-4.7";
      Planner-Sisyphus = "zai-coding-plan/glm-4.7";
      oracle = "openai/gpt-5.1-codex-max-high";
      frontend-ui-ux-engineer = "zai-coding-plan/glm-4.7";
      document-writer = "zai-coding-plan/glm-4.7";
      multimodal-looker = "openai/gpt-5.1-codex-max";
      explore = "zai-coding-plan/glm-4.7";
      librarian = "openai/gpt-5.1-codex-mini-high";
    };

    ## Google Gemini models
    gemini = {
      Sisyphus = "google/gemini-3-pro-preview";
      Sisyphus-Junior = "google/gemini-3-flash-preview";
      Planner-Sisyphus = "google/gemini-3-flash-preview";
      oracle = "google/gemini-3-pro-preview";
      frontend-ui-ux-engineer = "google/gemini-3-flash-preview";
      document-writer = "google/gemini-3-flash-preview";
      multimodal-looker = "google/gemini-3-flash-preview";
      explore = "google/gemini-3-flash-preview";
      librarian = "google/gemini-3-flash-preview";
    };

    ## Antigravity models (Google routed Claude/Gemini)
    agy = {
      Sisyphus = "google/antigravity-claude-opus-4-5-thinking";
      Sisyphus-Junior = "google/antigravity-claude-sonnet-4-5-thinking";
      Planner-Sisyphus = "google/antigravity-claude-sonnet-4-5-thinking";
      oracle = "google/antigravity-claude-opus-4-5-thinking";
      frontend-ui-ux-engineer = "google/antigravity-gemini-3-pro";
      document-writer = "google/antigravity-gemini-3-flash";
      multimodal-looker = "google/antigravity-gemini-3-pro";
      explore = "google/antigravity-claude-sonnet-4-5-thinking";
      librarian = "google/antigravity-gemini-3-flash";
    };

    ## Antigravity + native Claude hybrid
    agyclaude = {
      Sisyphus = "google/antigravity-claude-opus-4-5-thinking";
      Sisyphus-Junior = "anthropic/claude-sonnet-4-5";
      Planner-Sisyphus = "anthropic/claude-sonnet-4-5";
      oracle = "google/antigravity-claude-opus-4-5-thinking";
      frontend-ui-ux-engineer = "anthropic/claude-sonnet-4-5";
      document-writer = "anthropic/claude-haiku-4-5";
      multimodal-looker = "google/antigravity-gemini-3-pro";
      explore = "anthropic/claude-sonnet-4-5";
      librarian = "anthropic/claude-haiku-4-5";
    };

    ## GitHub Copilot models
    ghcp = {
      Sisyphus = "github-copilot/claude-opus-4.5";
      Sisyphus-Junior = "github-copilot/claude-sonnet-4.5";
      Planner-Sisyphus = "github-copilot/claude-sonnet-4.5";
      oracle = "github-copilot/claude-opus-4.5";
      frontend-ui-ux-engineer = "github-copilot/claude-sonnet-4.5";
      document-writer = "github-copilot/claude-haiku-4.5";
      multimodal-looker = "github-copilot/claude-sonnet-4.5";
      explore = "github-copilot/claude-sonnet-4.5";
      librarian = "github-copilot/claude-haiku-4.5";
    };

    ## Pure GLM models
    glm = {
      Sisyphus = "zai-coding-plan/glm-4.7";
      Sisyphus-Junior = "zai-coding-plan/glm-4.7";
      Planner-Sisyphus = "zai-coding-plan/glm-4.7";
      oracle = "zai-coding-plan/glm-4.7";
      frontend-ui-ux-engineer = "zai-coding-plan/glm-4.7";
      document-writer = "zai-coding-plan/glm-4.7";
      multimodal-looker = "zai-coding-plan/glm-4.7";
      explore = "zai-coding-plan/glm-4.7";
      librarian = "zai-coding-plan/glm-4.7";
    };

    ## OpenRouter free models
    openrouter = {
      Sisyphus = "openrouter/moonshotai/kimi-k2:free";
      Sisyphus-Junior = "openrouter/moonshotai/kimi-k2:free";
      Planner-Sisyphus = "openrouter/moonshotai/kimi-k2:free";
      oracle = "openrouter/moonshotai/kimi-k2:free";
      frontend-ui-ux-engineer = "openrouter/moonshotai/kimi-k2:free";
      document-writer = "openrouter/moonshotai/kimi-k2:free";
      multimodal-looker = "openrouter/moonshotai/kimi-k2:free";
      explore = "openrouter/moonshotai/kimi-k2:free";
      librarian = "openrouter/moonshotai/kimi-k2:free";
    };

    ## Zen profile (OpenCode free models)
    zen = {
      Sisyphus = "opencode/big-pickle";
      Sisyphus-Junior = "opencode/glm-4.7-free";
      Planner-Sisyphus = "opencode/big-pickle";
      oracle = "opencode/big-pickle";
      frontend-ui-ux-engineer = "opencode/minimax-m2.1-free";
      document-writer = "opencode/glm-4.7-free";
      multimodal-looker = "opencode/minimax-m2.1-free";
      explore = "opencode/glm-4.7-free";
      librarian = "opencode/glm-4.7-free";
    };
  };

  ## oh-my-opencode base config (shared across profiles)
  ohMyOpencodeBase = {
    "$schema" = "https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/master/assets/oh-my-opencode.schema.json";
    google_auth = false; ## Using Antigravity auth instead
    disabled_hooks = ["session-notification"];
    ralph_loop = {
      enabled = false;
    };
  };

  ## ghost.jsonc base config
  ghostConfig = {
    registries = {};
    componentPath = ".opencode";
  };

  ## Generate oh-my-opencode.jsonc for a profile
  mkOhMyOpencodeConfig = _profileName: agentModels:
    ohMyOpencodeBase
    // {
      agents = lib.genAttrs agentNames (agent: {
        model = agentModels.${agent};
      });
    };

  ## Generate profile directory contents
  mkProfileFiles = profileName: agentModels: let
    ohMyConfig = mkOhMyOpencodeConfig profileName agentModels;
  in {
    "opencode/profiles/${profileName}/oh-my-opencode.jsonc" = {
      inherit (cfg) enable;
      text = builtins.toJSON ohMyConfig;
    };
    "opencode/profiles/${profileName}/ghost.jsonc" = {
      inherit (cfg) enable;
      text = builtins.toJSON ghostConfig;
    };
  };

  ## Generate all profile files
  allProfileFiles =
    lib.foldl' (acc: profileName:
      acc // (mkProfileFiles profileName profiles.${profileName})) {} (lib.attrNames profiles);
in {
  ## Symlink oh-my-opencode.jsonc to current profile (managed by ocx)
  home.activation.opencodeProfileSymlink = mkIf config.programs.opencode.enable (
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD ln -sfn "profiles/current/oh-my-opencode.jsonc" \
        "''${XDG_CONFIG_HOME:-$HOME/.config}/opencode/oh-my-opencode.jsonc"
    ''
  );
  ## Profile switching is handled by ocx (pnpm dlx ocx)
  xdg.configFile = mkIf cfg.enable allProfileFiles;
  home.packages = lib.mkIf cfg.enable (lib.attrsets.attrValues {
    ocx = pkgs.writeShellScriptBin "ocx" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx ocx "$@"
    '';
  });
}
