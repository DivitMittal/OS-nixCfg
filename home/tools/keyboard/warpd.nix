{pkgs, ...}: {
  programs.warpd = {
    enable = true;
    package = pkgs.customDarwin.warpd;
    settings = {
      # Movement keys (Colemak home row)
      left = "h";
      down = ",";
      up = "e";
      right = ".";

      # Speed control
      speed = 220;
      acceleration = 1;

      # Cursor appearance
      cursor_color = "#ff0000";

      # Mouse buttons
      buttons = "l m y";

      # Grid configuration (2x2 grid)
      grid_nr = 2;
      grid_nc = 2;
      # (reading order: top-left, top-right, bottom-left, bottom-right)
      grid_keys = "n e h ,";

      # Hint configuration
      hint_chars = "arstneidhopgwyf";
      hint_bgcolor = "#000000"; # Black background
      hint_fgcolor = "#00ff00"; # Bright green foreground

      # Two-shot hint mode
      # Must have at least hint2_grid_size^2 = 9 characters
      hint2_chars = "arstneiodhpgwyfbvcxzqjklm";
      hint2_gap_size = 5;

      # Mode switching from within normal mode
      hint = "f";
      hint2 = "F";

      # Scrolling in normal mode
      scroll_down = "t";
      scroll_up = "p";
    };
  };
}
