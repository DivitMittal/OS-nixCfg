{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      gemini-cli
      #qwen-code
      #trae-agent
      #aider-chat-full
      ;
    openhands = pkgs.writeShellScriptBin "openhands" ''
      exec ${pkgs.uv}/bin/uv tool run --python 3.12 --from openhands-ai openhands "$@"
    '';
  };
}
