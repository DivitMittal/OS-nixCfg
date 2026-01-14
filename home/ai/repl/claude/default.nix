{
  pkgs,
  lib,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  home.packages = lib.attrsets.attrValues {
    ## CCUsage
    # ccusage = pkgs.writeShellScriptBin "ccusage" ''
    #   exec ${pkgs.pnpm}/bin/pnpm dlx ccusage@latest "$@"
    # '';
    inherit (pkgs.ai) ccusage;
    ## Claude Code Router
    claude-code-router = pkgs.writeShellScriptBin "ccr" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx @musistudio/claude-code-router "$@"
    '';
    # inherit (pkgs.ai) claude-code-router;
    ## CCStatusLine
    inherit (pkgs.ai) ccstatusline;
  };

  programs.claude-code = {
    enable = true;
    package = pkgs.ai.claude-code;
  };
}
