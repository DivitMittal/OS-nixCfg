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
    ## Office -> Markdown
    markitdown = lib.custom.mkUvxBin "markitdown" "markitdown[all]";
  };
}
