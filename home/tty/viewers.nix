{
  pkgs,
  lib,
  ...
}: {
  programs.visidata = {
    enable = true;
    package = pkgs.stable.visidata;
  };

  home.packages = lib.attrsets.attrValues {
    sc-im = pkgs.sc-im.override {
      xlsSupport = true;
      inherit (pkgs.custom) libxls;
    };
    ouch = pkgs.ouch.override {enableUnfree = true;}; # archives (with RAR support)
    inherit
      (pkgs)
      doxx # docx
      pandoc # various docs
      hexyl # binary & misc.
      poppler # PDFs
      ;
    ## Euporie (Jupyter client)
    euporie-notebook = pkgs.writeScriptBin "euporie-notebook" ''
      exec ${pkgs.uv}/bin/uv tool run --from euporie euporie-notebook "$@"
    '';
    euporie-preview = pkgs.writeScriptBin "euporie-preview" ''
      exec ${pkgs.uv}/bin/uv tool run --from euporie euporie-preview "$@"
    '';
    euporie = pkgs.writeScriptBin "euporie" ''
      exec ${pkgs.uv}/bin/uv tool run --from euporie euporie "$@"
    '';
    ## Office -> Markdown
    markitdown = pkgs.writeScriptBin "markitdown" ''
      exec ${pkgs.uv}/bin/uv tool run markitdown[all] "$@"
    '';
  };
}
