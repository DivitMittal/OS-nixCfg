{
  lib,
  pkgs,
  inputs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs.master)
      gemini-cli
      #qwen-code
      #trae-agent
      ;
    inherit
      (pkgs)
      geminicommit
      #aider-chat-full
      ;
    aicommit2 = inputs.aicommit2.packages.${pkgs.system}.default;
    openhands = pkgs.writeShellScriptBin "openhands" ''
      exec ${pkgs.uv}/bin/uv tool run --python 3.12 --from openhands-ai openhands "$@"
    '';
  };
}
