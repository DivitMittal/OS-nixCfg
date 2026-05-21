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
    euporie-notebook = lib.custom.mkUvxBin "euporie-notebook" "--from euporie euporie-notebook";
    euporie-preview = lib.custom.mkUvxBin "euporie-preview" "--from euporie euporie-preview";
    euporie = lib.custom.mkUvxBin "euporie" "--from euporie euporie";
    ## Office -> Markdown
    markitdown = lib.custom.mkUvxBin "markitdown" "markitdown[all]";
  };
}
