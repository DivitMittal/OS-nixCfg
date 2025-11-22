{pkgs, ...}: {
  programs.warpd = {
    enable = true;
    package = pkgs.customDarwin.warpd;
    settings = {
      # Activation keys
      activation_key = "A-M-c"; # Alt+Cmd+c to activate normal mode
      hint_activation_key = "C-A-M-S-h"; # Hyper+h (Ctrl+Alt+Cmd+Shift+h) for hint mode
      grid_activation_key = "A-M-g"; # Alt+Cmd+g for grid mode

      # Movement keys (Colemak-DH: neui replaces hjkl)
      left = "n";
      down = "e";
      up = "u";
      right = "i";

      # Screen edge movement (Shift+neui for NEUI)
      start = "N"; # Left edge (Shift+n)
      bottom = "E"; # Bottom edge (Shift+e)
      top = "U"; # Top edge (Shift+u)
      end = "I"; # Right edge (Shift+i)

      # Speed control
      speed = 220;
      acceleration = 1;

      # Cursor appearance in normal mode
      cursor_color = "#ff0000"; # Pure red for high visibility

      # Mouse buttons
      buttons = "l , y"; # l=left click, ,=middle, y=right click

      # Grid configuration (2x2 grid)
      grid_nr = 2; # Number of rows
      grid_nc = 2; # Number of columns
      # Override grid_keys to avoid conflict with 'u' (up) and 'i' (right)
      # Using Colemak-DH compatible keys: w,f,p,g (bookwise: top-left, top-right, bottom-left, bottom-right)
      grid_keys = "w f p g";

      # Hint configuration (Colemak-DH home row, excluding navigation keys)
      hint_chars = "arstdhofpgwy";
      hint_bgcolor = "#000000"; # Black background
      hint_fgcolor = "#00ff00"; # Bright green foreground

      # Two-shot hint mode (Colemak-DH optimized)
      # Primary home row: a r s t d h (excluding neui navigation keys)
      # Secondary rows and easily reachable keys
      # Must have at least hint2_grid_size^2 = 9 characters
      hint2_chars = "arstdhneifpgwybvcxzqjklmo";
      hint2_gap_size = 5; # Increased spacing for better visibility (default: 1)

      # Mode switching from within normal mode
      hint2 = "f"; # Activate two-shot hint mode (default: X)

      # Exit normal mode
      exit = "esc";

      # Screen selection (for multi-monitor)
      screen = "s";

      # Scrolling in normal mode
      scroll_down = "d";
      scroll_up = "t"; # Changed from 'u' since u is now used for up movement
    };
  };
}
