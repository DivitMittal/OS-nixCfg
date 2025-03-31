{ config, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    # All interactive sessions
    initExtra = ''
      export BADOTDIR="${config.xdg.configHome}/bash"
      export HISTFILE="''${BADOTDIR:-$HOME}/.bash_history"

      # vi keybindings
      set -o vi
    '';
  };
}