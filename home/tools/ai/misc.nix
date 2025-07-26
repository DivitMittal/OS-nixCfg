{
  lib,
  pkgs,
  inputs,
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
      ;
    aicommit2 = inputs.aicommit2.packages.${pkgs.system}.default;
  };

  programs.opencode = {
    enable = true;
    package = pkgs.master.opencode;
  };
}
