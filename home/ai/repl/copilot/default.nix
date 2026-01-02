{
  pkgs,
  lib,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  programs.github-copilot = {
    enable = true;
    package = pkgs.writeShellScriptBin "copilot" ''
      exec ${pkgs.ai.copilot-cli}/bin/copilot --enable-all-github-mcp-tools --banner "$@"
    '';
  };
}
