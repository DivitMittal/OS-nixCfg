{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    # inherit(pkgs.ai)
    #   ## Spec-driven tools
    #   #spec-kit
    #   ;
    openspec = pkgs.writeShellScriptBin "openspec" ''
      exec ${pkgs.uv}/bin/uv tool run @fission-ai/openspec@latest "$@"
    '';
  };
}
