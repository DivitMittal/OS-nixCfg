{
  pkgs,
  hostPlatform,
  lib,
  ...
}: let
  mkCalibreAlias = name: "${pkgs.brewCasks.calibre}/Applications/calibre.app/Contents/MacOS/${name}";

  calibreBinaries = [
    "calibre"
    "calibre-complete"
    "calibre-customize"
    "calibre-debug"
    "calibre-parallel"
    "calibre-server"
    "calibre-smtp"
    "calibredb"
    "ebook-convert"
    "ebook-device"
    "ebook-edit"
    "ebook-meta"
    "ebook-polish"
    "ebook-viewer"
    "fetch-ebook-metadata"
    "lrf2lrs"
    "lrfviewer"
    "lrs2lrf"
    "markdown-calibre"
    "web2disk"
  ];
in {
  home.packages = lib.attrsets.attrValues {
    calibre =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.calibre
      else pkgs.calibre;

    # Office files (e.g., .docx, .xlsx, .pptx) editors/viewer
    onlyoffice =
      if hostPlatform.isDarwin
      then (pkgs.brewCasks.onlyoffice.override {variation = "sequoia";})
      else pkgs.onlyoffice;
    libreoffice =
      if hostPlatform.isDarwin
      then pkgs.libreoffice-bin
      else pkgs.libreoffice;

    microsoft-excel =
      if hostPlatform.isDarwin
      then
        pkgs.brewCasks.microsoft-excel.overrideAttrs (oldAttrs: {
          installPhase =
            oldAttrs.installPhase
            + ''
              # Clean Resources
              echo "Removing entire Resources directory from microsoft-excel installation..."
              local resource_dir="$out/Resources"

              if [ -d "$resource_dir" ]; then
                echo "Found directory '$resource_dir' and removing it..."
                rm -rf "$resource_dir"
              else
                echo "Warning: Resources directory '$resource_dir' not found. It may have been removed already or path is wrong." >&2
              fi
              echo "Finished cleanup (removed Resources) for microsoft-excel."
            '';
        })
      else null;
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

  home.shellAliases =
    lib.mkIf hostPlatform.isDarwin
    (
      {
        soffice = "${pkgs.libreoffice-bin}/Applications/LibreOffice.app/Contents/MacOS/soffice";
      }
      // lib.genAttrs calibreBinaries mkCalibreAlias
    );
}
