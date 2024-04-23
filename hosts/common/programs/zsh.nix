_:
{
  zsh = {
    enable = true;

    promptInit = "PS1='%F{cyan}%~%f %# '";

    interactiveShellInit = ''
      [[ "$(locale LC_CTYPE)" == "UTF-8" ]] && setopt COMBINING_CHARS   # UTF-8 with combining characters
      setopt BEEP                                                       # beep on error

      disable log                                                       # avoid conflict with /usr/bin/log
      unalias run-help                                                  # Remove the default of run-help being aliased to man
      autoload run-help                                                 # Use zsh's run-help, which will display information for zsh builtins.

      # Default key bindings
      [[ -n ''${key[Delete]} ]] && bindkey "''${key[Delete]}" delete-char
      [[ -n ''${key[Home]} ]]   && bindkey "''${key[Home]}" beginning-of-line
      [[ -n ''${key[End]} ]]    && bindkey "''${key[End]}" end-of-line
      [[ -n ''${key[Up]} ]]     && bindkey "''${key[Up]}" up-line-or-search
      [[ -n ''${key[Down]} ]]   && bindkey "''${key[Down]}" down-line-or-search

      [ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM" # Useful support for interacting with Terminal.app or other terminal programs
    '';
  };
}