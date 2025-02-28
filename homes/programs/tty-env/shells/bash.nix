{ config, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    # All interactive sessions
    initExtra = ''
      export BADOTDIR="${config.xdg.configHome}/bash"
      export HISTFILE="''${BADOTDIR:-$HOME}/.bash_history"

      # Prompt
      if [ "`id -u`" -eq 0 ]; then # ckeck for root user
        PS1="\[\e[1;31m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\w]> \[\e[0m\]"
      else
        PS1="\[\e[1m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\w]> \[\e[0m\]"
      fi

      # vi keybindings
      set -o vi
    '';

    # All login sessions
    profileExtra = ''
      export GIT_HOSTING='git@github.com:${config.programs.git.userName}' # Place for hosting Git repos
      unset MAILCHECK # Don't check mail when opening terminal.
    '';
  };
}