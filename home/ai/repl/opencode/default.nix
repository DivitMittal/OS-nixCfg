{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  imports = lib.custom.scanPaths ./.;

  home.packages = mkIf config.programs.opencode.enable (lib.attrsets.attrValues {
    inherit (pkgs.ai) ccusage-opencode;
  });

  programs.opencode = let
    package = pkgs.writeShellScriptBin "opencode" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx opencode-ai "$@"
    '';
    # package = pkgs.ai.opencode;
  in {
    enable = true;
    inherit package;

    enableMcpIntegration = false;

    settings = {
      autoupdate = false;
      autoshare = false;

      ## oh-my-opencode inherits from claude-code:
      ## - mcp
      ## - commands
      ## - skills
      ## - agents
      ## - hooks
      ## - plugins
      plugin = [
        "oh-my-opencode"
        "opencode-antigravity-auth@beta"
      ];
    };
  };
}
