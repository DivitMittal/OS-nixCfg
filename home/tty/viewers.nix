{
  pkgs,
  lib,
  ...
}: {
  # arrow-cpp-23.0.0 is meta.broken across nixpkgs 26.05/unstable/master as
  # of 2026-07-19, so the in-tree visidata fails on darwin. PyPI ships
  # working cp312-macosx wheels (pyarrow bundles a healthy arrow-cpp), so
  # substitute the uvx-installed binary for the nixpkgs package directly.
  programs.visidata = {
    enable = true;
    package = lib.custom.mkUvxBin "visidata" "visidata";
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
