{inputs, ...}: {
  imports = [inputs.paneru.homeModules.paneru];

  services.paneru = {
    enable = true;
    settings = {
      options = {
        # Match yabai: both off (fn key is used for mouse move/resize via yabai)
        focus_follows_mouse = false;
        mouse_follows_focus = false;
        # Cycle widths matching hammerspoon's numpad fractions (0,4,5,6 positions)
        preset_column_widths = [0.25 0.33 0.5 0.66 0.75];
        # Very fast: yabai has 0ms animation
        animation_speed = 1000;
      };

      padding = {
        # Match yabai's 8px padding on all sides
        top = 8;
        bottom = 8;
        left = 8;
        right = 8;
      };

      bindings = {
        ## Focus — alt+ctrl+cmd (@sWin) + vim hjkl
        # arrows are taken (yabai space/window nav), 0-9 taken (hammerspoon numpad)
        window_focus_west = "alt + ctrl + cmd - h";
        window_focus_east = "alt + ctrl + cmd - l";
        window_focus_north = "alt + ctrl + cmd - k";
        window_focus_south = "alt + ctrl + cmd - j";
        window_focus_first = "alt + ctrl + cmd - ["; # jump to leftmost column
        window_focus_last = "alt + ctrl + cmd - ]"; # jump to rightmost column

        ## Swap — hyper (@sHyp = shift+alt+ctrl+cmd) + vim hjkl
        # hyper+h/j/k/l are free in hammerspoon
        window_swap_west = "shift + alt + ctrl + cmd - h";
        window_swap_east = "shift + alt + ctrl + cmd - l";
        window_swap_north = "shift + alt + ctrl + cmd - k";
        window_swap_south = "shift + alt + ctrl + cmd - j";
        window_swap_first = "shift + alt + ctrl + cmd - [";
        window_swap_last = "shift + alt + ctrl + cmd - ]";

        ## Sizing — alt+ctrl+cmd (without shift avoids hammerspoon hyper conflicts)
        window_grow = "alt + ctrl + cmd - r"; # cycle grow
        window_shrink = "shift + alt + ctrl + cmd - r"; # cycle shrink (hyper+r is free)
        window_fullwidth = "alt + ctrl + cmd - f"; # toggle full-width
        window_center = "alt + ctrl + cmd - o"; # 'c' is create-space, use 'o'

        ## Stack management
        window_equalize = "alt + ctrl + cmd - e"; # equalize stack heights
        window_stack = "alt + ctrl + cmd - s"; # stack into left column
        window_unstack = "alt + ctrl + cmd - u"; # pull out of stack
        window_manage = "alt + ctrl + cmd - t"; # toggle float ↔ tiled

        ## Misc
        window_snap = "alt + ctrl + cmd - z"; # snap overflow into viewport
        window_nextdisplay = "alt + ctrl + cmd - n"; # move + follow to next display

        ## Quit
        quit = "ctrl + alt - q"; # intentionally no cmd — matches paneru default
      };
    };
  };
}
