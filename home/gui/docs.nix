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
in {
  ## Calibre ebook management
  programs.calibre = {
    enable = true;
    package =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.calibre
      else pkgs.calibre;
  };

  home.packages = calibreWrappers;

  ## PDF viewer for research papers and technical books
  programs.sioyek = {
    enable = true;
    package = pkgs.sioyek;

    bindings = {
      ## Colemak-DH navigation: inverted-T arrow-key orientation (neui)
      #       u (↑)
      #   n   e   i   (← ↓ →)
      move_visual_mark_up = "u";
      move_visual_mark_down = "e";
      move_left = "n";
      move_right = "i";

      ## 'n' is now pan-left; physical 'n' key sends 'k' in Colemak-DH
      next_item = "k";

      ## Mnemonic shortcut for dark mode toggle (F8 still works)
      toggle_dark_mode = "td";
    };

    config = {
      default_dark_mode = "1";
      custom_background_color = "0.18 0.20 0.25"; # dark blue-grey page
      custom_text_color = "0.85 0.87 0.91"; # soft white text
      dark_mode_contrast = "0.85";
      zoom_inc_factor = "1.2";
      wheel_zoom_on_cursor = "1"; # zoom toward pointer

      ## Reading aids
      ruler_mode = "1"; # horizontal reading ruler
      single_click_selects_words = "1"; # easier word selection

      ## Behaviour
      should_launch_new_instance = "0"; # reuse single window
      check_for_updates_on_startup = "0";
    };
  };

  ## PDF, EPUB, Djvu reader
  programs.zathura = {
    enable = false;
    package = pkgs.zathura;
    options = {
      adjust-open = "best-fit";
      pages-per-row = 1;
      scroll-page-aware = "true"; ## mindful of the page's end
      smooth-scroll = "true";
      scroll-full-overlap = 0.01;
      scroll-step = 100;
    };
  };
}
