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
    ralph-tui = pkgs.writeShellScriptBin "ralph-tui" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx ralph-tui "$@"
    '';

    ## Memory System (Issue Tracker)
    bead = pkgs.writeShellScriptBin "bd" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx @beads/bd "$@"
    '';

    inherit (pkgs.custom) bv-bin;
  };
}
