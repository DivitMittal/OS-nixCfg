{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs.master)
      gemini-cli
      #qwen-code
      #trae-agent
      ;
    inherit
      (pkgs)
      geminicommit
      kaggle
      claude-code
      #aider-chat-full
      ;
    inherit (pkgs.nur.repos.charmbracelet) crush;
    hf = pkgs.writeShellScriptBin "hf" ''
      exec ${pkgs.uv}/bin/uv tool run --from huggingface-hub[cli] hf "$@"
    '';
    aicommit2 = inputs.aicommit2.packages.${pkgs.system}.default;
  };

  home.sessionVariables = {
    KAGGLE_CONFIG_DIR = "${config.xdg.configHome}/kaggle";
    HF_HUB_DISABLE_TELEMETRY = "1";
  };

  programs.opencode = {
    enable = true;
    package = pkgs.master.opencode;
  };
}
