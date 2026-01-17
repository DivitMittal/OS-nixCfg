{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    ## Spec-driven Development
    # inherit(pkgs.ai)
    #   ## Spec-driven tools
    #   #spec-kit
    #   ;
    openspec = pkgs.writeShellScriptBin "openspec" ''
      exec ${pkgs.uv}/bin/uv tool run @fission-ai/openspec@latest "$@"
    '';

    ## Ralph Wiggum
    ralph = pkgs.writeShellScriptBin "ralph" ''
      exec ${pkgs.uv}/bin/uv tool --from ralph-orchestrator run ralph "$@"
    '';

    ## Memory System
    inherit (pkgs) beads;
    inherit (pkgs.custom) bv-bin;
  };
}
