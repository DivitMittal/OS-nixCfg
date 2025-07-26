{
  lib,
  pkgs,
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
  };

  programs.opencode = {
    enable = true;
    package = pkgs.master.opencode;
  };
}
