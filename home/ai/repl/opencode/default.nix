{
  pkgs,
  lib,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  home.packages = lib.attrsets.attrValues {
    inherit (pkgs.ai) ccusage-opencode;
  };

  programs.opencode = {
    enable = true;
    package = pkgs.writeShellScriptBin "opencode" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx opencode-ai "$@"
    '';
    # package = pkgs.ai.opencode;
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
