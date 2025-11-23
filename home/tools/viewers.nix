{
  pkgs,
  lib,
  ...
}: {
  programs.visidata = {
    enable = true;
    package = pkgs.nixosStable.visidata;
  };

  home.packages = lib.attrsets.attrValues {
    sc-im = pkgs.sc-im.override {
      xlsSupport = true;
      inherit (pkgs.custom) libxls;
    };
    inherit
      (pkgs)
      doxx # docx
      pandoc # various docs
      ouch # archives
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
    markitdown = pkgs.writeScriptBin "markitdown" ''
      exec ${pkgs.uv}/bin/uv tool run markitdown[all] "$@"
    '';
  };
}
