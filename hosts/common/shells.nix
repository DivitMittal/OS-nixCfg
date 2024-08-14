{ pkgs, ... }:

{
  environment = {
    shells = with pkgs;[bashInteractive zsh dash fish];

    variables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_STATE_HOME  = "$HOME/.local/state";
      XDG_DATA_HOME   = "$HOME/.local/share";
      LANG            = "en_US.UTF-8";
      EDITOR          = "vim";
      VISUAL          = "vim";
    };

    shellAliases = {
      ls       = "env ls -aF";
      ll       = "env ls -alHbhigUuS";
      ed       = "${pkgs.ed} -v -p ':'";
      showpath = ''echo $PATH | sed "s/ /\n/g"'';
      showid   = ''id | sed "s/ /\n/g"'' ;
    };
  };

  programs = {
    bash = {
      enable = true;

      interactiveShellInit = ''
        # [ -z "$PS1" ] && return                                             # exit if running non-interactively (handled by nix-darwin)

        if [ "`id -u`" -eq 0 ]; then
          PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1;31m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"
        else
          PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"
        fi

        set -o vi                                                             # vi keybindings

        # shopt -s checkwinsize                                               # check window size after every command (handled by nix-darwin)
      '';
    };

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
      '';
    };

    fish = {
      enable = true;

      vendor = {
        config.enable      = true;
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
  };
}