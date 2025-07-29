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
      ;
    hf = pkgs.python313Packages.huggingface-hub;
    aicommit2 = inputs.aicommit2.packages.${pkgs.system}.default;
  };

  home.sessionVariables.KAGGLE_CONFIG_DIR = "${config.xdg.configHome}/kaggle";

  programs.opencode = {
    enable = true;
    package = pkgs.master.opencode;
  };
}
