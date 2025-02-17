{ pkgs, pkgs-darwin, lib, ... }:
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
      LANG            = "en_US.UTF-8";
      VISUAL          = "vim";
      EDITOR          = "${VISUAL}";
    };

    shellAliases = {
      ls = "env ls -aF";
      ll = "env ls -alHbhigUuS";
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