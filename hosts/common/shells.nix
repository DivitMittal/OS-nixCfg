{ pkgs, pkgs-darwin, lib, username, config, ... }:
let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  environment.shells = builtins.attrValues {
    bash = if isDarwin then pkgs-darwin.bashInteractive else pkgs.bashInteractive;
    zsh = if isDarwin then pkgs-darwin.zsh else pkgs.zsh;
    dash = if isDarwin then pkgs-darwin.dash else pkgs.dash;
    fish = if isDarwin then pkgs-darwin.fish else pkgs.fish;
  };

  environment = {
    variables = rec {
      HOME            = if isDarwin then "/Users/${username}" else "/home/${username}";
      XDG_CONFIG_HOME = "~/.config";
      XDG_CACHE_HOME  = "~/.cache";
      XDG_STATE_HOME  = "~/.local/state";
      XDG_DATA_HOME   = "~/.local/share";
      BIN_HOME        = "~/.local/bin";
      LANG            = "en_US.UTF-8";
      VISUAL          = "vim";
      EDITOR          = "${VISUAL}";
    };

    shellAliases = {
      ls = "env ls -aF";
      ll = "env ls -alHbhigUuS";
      ed = "${pkgs.ed}/bin/ed -v -p ':'";
    };
  };

  programs = let inherit(lib) mkDefault; in {
    bash = {
      enable = mkDefault true;

      completion = {
        enable = false;
        package = pkgs.bash-completion;
      };

      interactiveShellInit = ''
        # Exit if running non-interactively (handled by nix-darwin)
        # [ -z "$PS1" ] && return

        # Prompt
        if [ "`id -u`" -eq 0 ]; then # ckeck for root user
          PS1="\[\e[1;31m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\w]> \[\e[0m\]"
        else
          PS1="\[\e[1m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\w]> \[\e[0m\]"
        fi

        # vi keybindings
        set -o vi

        # Check window size after every command (handled by nix-darwin)
        # shopt -s checkwinsize
      '';
    };

    zsh = {
      enable = mkDefault true;

      enableBashCompletion = false;
      enableCompletion = false; enableGlobalCompInit=false;
      enableSyntaxHighlighting = false;

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
      enable = mkDefault true;
      useBabelfish = true;
      babelfishPackage = pkgs.babelfish;

      vendor = {
        config.enable      = true;
        completions.enable = true;
        functions.enable   = true;
      };

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