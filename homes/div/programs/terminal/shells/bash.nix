{ config, ... }:

{
  programs.bash = {
    enable = true;

    # All interactive sessions
    initExtra = ''
      export BADOTDIR="${config.home.homeDirectory}/.config/bash"
      export HISTFILE="''${BADOTDIR:-$HOME}/.bash_history"
    '';

    # All login sessions
    profileExtra = ''
      export GIT_HOSTING='git@github.com:${config.programs.git.userName}' # Place for hosting Git repos
      unset MAILCHECK # Don't check mail when opening terminal.
    '';
  };
}