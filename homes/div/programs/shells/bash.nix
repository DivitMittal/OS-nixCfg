{ config, ... }:

{
  programs.bash = {
    enable = true;
    # All interactive sessions
    initExtra = ''
      export BADOTDIR="${config.home.homeDirectory}/.config/bash"
      export HISTFILE="''${BADOTDIR:-$HOME}/.bash_history"
    '';
  };
}