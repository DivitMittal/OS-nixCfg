{pkgs, ...}: {
  programs.warpd = {
    enable = true;
    package = pkgs.customDarwin.warpd;
    settings = {
      ## Normal mode movement
      left = "n";
      down = "e";
      up = "u";
      right = "i";

      ## Speed
      speed = 220;
      max_speed = 1600;
      acceleration = 700;
      decelerator_speed = 50;

      ## Scrolling (capitalised counterparts of the movement keys)
      scroll_down = "M";
      scroll_up = "J";
      scroll_left = "T";
      scroll_right = "R";

      ## Cursor appearance
      cursor_color = "#ff0000";
      cursor_size = 7;
      indicator = "topright";
      indicator_color = "#ff0000";
      indicator_size = 12;

      ## Mouse buttons (t=left, comma=middle, g=right)
      buttons = "t , g";

      ## In-normal-mode actions (defaults kept unless they conflict)
      # drag = "v";          # toggle drag/visual mode
      # copy = "y";
      # copy_and_exit = "c";
      # paste = "p";
      # accelerator = "a";
      # decelerator = "d";
      hint = "x"; # activate hint (was f in old config; x is unambiguous)
      hint2 = "X"; # two-pass hint
      smart_hint = "f"; # smart/element-based hints
      grid = "g";
      screen = "s";
      history = ";";

      ## Grid mode (2×2)
      grid_nr = 2;
      grid_nc = 2;

      # Grid overlay navigation mirrors normal mode movement (grid mode is separate)
      grid_left = "n";
      grid_down = "e";
      grid_up = "u";
      grid_right = "i";
      grid_cut_left = "N";
      grid_cut_down = "E";
      grid_cut_up = "U";
      grid_cut_right = "I";

      # Quadrant selection: physical QWAS cluster (Colemak: q/w/a/r) — avoids n/e/u/i
      # reading order: top-left, top-right, bottom-left, bottom-right
      grid_keys = "q w a r";

      ## Hint configuration (Colemak home-row biased character set)
      hint_chars = "arstneidhopgwyf";
      hint_bgcolor = "#000000";
      hint_fgcolor = "#00ff00";
      hint_size = 20;

      ## Two-shot hint mode (≥ hint2_grid_size² = 9 chars required)
      hint2_chars = "arstneiodhpgwyfbvcxzqjklm";
      hint2_gap_size = 5;
      hint2_grid_size = 3;

      ## Screen selection (Colemak home row)
      screen_chars = "arstdhneio";

      ## Smart hint mode
      smart_hint_mode = "alphabet";
    };
  };
}
