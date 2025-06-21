{
  pkgs,
  hostPlatform,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    # Office files (e.g., .docx, .xlsx, .pptx) editors/viewer
    onlyoffice =
      if hostPlatform.isDarwin
      then (pkgs.brewCasks.onlyoffice.override {variation = "sequoia";})
      else pkgs.onlyoffice;
    libreoffice =
      if hostPlatform.isDarwin
      then pkgs.libreoffice-bin
      else pkgs.libreoffice;
  };

  # PDF, EPUB, Djvu reader
  programs.zathura = {
    enable = true;
    package = pkgs.zathura;
    options = {
      adjust-open = "best-fit";
      pages-per-row = 1;
      scroll-page-aware = "true"; # mindful of the page's end
      smooth-scroll = "true";
      scroll-full-overlap = 0.01;
      scroll-step = 100;
    };
  };
}
