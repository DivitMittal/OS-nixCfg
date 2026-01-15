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
    ocx = pkgs.writeShellScriptBin "ocx" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx ocx "$@"
    '';
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
      theme = "system";

      plugin = [
        "oh-my-opencode"
        "opencode-antigravity-auth@1.1.2"
      ];
    };
  };
}
