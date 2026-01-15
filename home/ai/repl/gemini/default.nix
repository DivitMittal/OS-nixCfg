{
  pkgs,
  lib,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  programs.gemini-cli = {
    enable = true;
    package = pkgs.writeShellScriptBin "gemini" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx @google/gemini-cli "$@"
    '';
    # package = pkgs.ai.gemini-cli;
    defaultModel = "gemini-3-pro-preview";
  };
}
