{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    openhands = pkgs.writeShellScriptBin "openhands" ''
      exec ${pkgs.uv}/bin/uv tool run --python 3.12 --from openhands-ai openhands "$@"
    '';
    gemini = pkgs.writeShellScriptBin "gemini" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx @google/gemini-cli@latest "$@"
    '';
    aider = pkgs.writeShellScriptBin "aider" ''
      exec ${pkgs.uv}/bin/uv tool run --python python3.12 --with pip --from aider-chat@latest aider "$@"
    '';
  };
}
