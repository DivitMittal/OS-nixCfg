_:

{
  programs.fish = {
    enable = true;

    vendor = {
      config.enable = true;
      completions.enable = true;
      functions.enable   = true;
    };

    useBabelfish = true;
    shellInit = ''
      set -g fish_greeting
    '';
    interactiveShellInit = ''
      set -g fish_vi_force_cursor 1
      set -g fish_cursor_default block
      set -g fish_cursor_visual block
      set -g fish_cursor_insert line
      set -g fish_cursor_replace_one underscore
    '';
  };
}