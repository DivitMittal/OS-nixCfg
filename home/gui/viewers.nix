{
  pkgs,
  hostPlatform,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    # Office files (e.g., .docx, .xlsx, .pptx) editors
    onlyoffice =
      if hostPlatform.isDarwin
      then (pkgs.brewCasks.onlyoffice.override {variation = "sequoia";})
      else pkgs.onlyoffice;
  };

  # PDF, EPUB, Djvu reader
  programs.zathura = {
    enable = true;
    package = pkgs.zathura;
  };
}
