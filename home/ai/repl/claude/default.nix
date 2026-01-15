{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  imports = lib.custom.scanPaths ./.;

  home.packages = mkIf config.programs.claude-code.enable (lib.attrsets.attrValues {
    ## CCUsage
    inherit (pkgs.ai) ccusage;
    ## CCStatusLine
    inherit (pkgs.ai) ccstatusline;
    claude-code-switcher = pkgs.writeShellScriptBin "ccs" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx @kaitranntt/ccs "$@"
    '';
  });

  programs.claude-code = {
    enable = true;
    package = pkgs.ai.claude-code;
  };
}
