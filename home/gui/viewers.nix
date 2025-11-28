{
  pkgs,
  hostPlatform,
  lib,
  ...
}: let
  mkCalibreWrapper = name:
    pkgs.writeShellScriptBin name ''
      exec ${pkgs.brewCasks.calibre}/Applications/calibre.app/Contents/MacOS/${name} "$@"
    '';

  calibreBinaries = [
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

  calibreWrappers = lib.optionals hostPlatform.isDarwin (map mkCalibreWrapper calibreBinaries);

  sofficeWrapper = lib.optional hostPlatform.isDarwin (
    pkgs.writeShellScriptBin "soffice" ''
      exec ${pkgs.libreoffice-bin}/Applications/LibreOffice.app/Contents/MacOS/soffice "$@"
    ''
  );
in {
  home.packages =
    lib.attrsets.attrValues {
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
        then
          pkgs.libreoffice-bin.overrideAttrs (oldAttrs: {
            installPhase =
              oldAttrs.installPhase
              + ''
                rm -f $out/bin/soffice
              '';
          })
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

                # Remove shared components to avoid collision with other Office apps
                echo "Removing shared licensing helper from microsoft-excel..."
                local helper_dir="$out/Library/PrivilegedHelperTools"
                if [ -d "$helper_dir" ]; then
                  rm -rf "$helper_dir"
                  echo "Removed PrivilegedHelperTools directory."
                fi

                echo "Removing Microsoft AutoUpdate app from microsoft-excel..."
                local autoupdate_app="$out/Applications/Microsoft AutoUpdate.app"
                if [ -d "$autoupdate_app" ]; then
                  rm -rf "$autoupdate_app"
                  echo "Removed Microsoft AutoUpdate.app"
                fi
              '';
          })
        else null;
    }
    ++ calibreWrappers
    ++ sofficeWrapper;

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
