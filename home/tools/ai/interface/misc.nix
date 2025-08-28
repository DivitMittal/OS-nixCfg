{
  lib,
  pkgs,
  inputs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    openhands = pkgs.writeShellScriptBin "openhands" ''
      exec ${pkgs.uv}/bin/uv tool run --python 3.12 --from openhands-ai openhands "$@"
    '';
    aider = pkgs.writeShellScriptBin "aider" ''
      exec ${pkgs.uv}/bin/uv tool run --python python3.12 --with pip --from aider-chat@latest aider "$@"
    '';
    inherit
      (inputs.nix-ai-tools.packages.${pkgs.system})
      #amp
      #qwen-code
      #catnip
      cursor-agent
      forge
      goose-cli
      groq-code-cli
      ;
  };
}
