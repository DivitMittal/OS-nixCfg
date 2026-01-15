{
  pkgs,
  lib,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  home.packages = lib.attrsets.attrValues {
    ## CCUsage
    inherit (pkgs.ai) ccusage;
    ## CCStatusLine
    inherit (pkgs.ai) ccstatusline;
    claude-code-switcher = pkgs.writeShellScriptBin "ccs" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx @kaitranntt/ccs "$@"
    '';
  };

  programs.claude-code = {
    enable = true;
    package = pkgs.ai.claude-code;
  };
}
