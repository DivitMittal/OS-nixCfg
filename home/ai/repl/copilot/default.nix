{
  pkgs,
  lib,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  programs.github-copilot = {
    enable = false;
    package = pkgs.writeShellScriptBin "copilot" ''
      exec ${pkgs.ai.copilot-cli}/bin/copilot --enable-all-github-mcp-tools --banner "$@"
    '';
  };
}
