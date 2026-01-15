{
  pkgs,
  lib,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  home.packages = lib.attrsets.attrValues {
    inherit (pkgs.ai) ccusage-codex;
  };

  programs.codex = let
    # package = pkgs.ai.codex;
    package = pkgs.writeShellScriptBin "codex" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx @openai/codex "$@"
    '';
  in {
    enable = true;
    inherit package;
  };
}
