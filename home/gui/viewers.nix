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

  # Fix for LibreOffice on macOS: use the binary from within the app bundle
  # The symlinked soffice in PATH doesn't work properly on Darwin
  home.shellAliases = lib.mkIf hostPlatform.isDarwin {
    soffice = "${pkgs.libreoffice-bin}/Applications/LibreOffice.app/Contents/MacOS/soffice";
  };
}
