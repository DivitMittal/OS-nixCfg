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
  };

  programs.opencode = {
    enable = true;
    package = pkgs.master.opencode;
  };
}
