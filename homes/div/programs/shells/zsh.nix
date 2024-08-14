{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;

    dotDir = ".config/zsh";
    history = {
      extended              = false; # save timestamps as well
      expireDuplicatesFirst = true; ignoreAllDups = true;
      path                  = "$ZDOTDIR/.zsh_history";
      share                 = true;
    };
    defaultKeymap = null;

    profileExtra = ''
      # Place for hosting Git repos
      export GIT_HOSTING='git@github.com:${config.programs.git.userName}'

      # Don't check mail when opening terminal.
      unset MAILCHECK

      # Change this to your console based IRC client of choice.
      export IRC_CLIENT='weechat'

      # Set Xterm/screen/Tmux title with only a short hostname.
      export SHORT_HOSTNAME=$(hostname -s)

      # Set Xterm/screen/Tmux title with only a short username.
      export SHORT_USER=''${USER:0:8}

      # Set Xterm/screen/Tmux title with shortened command and directory.
      export SHORT_TERM_LINE=true
    '';

    enableCompletion = true;

    syntaxHighlighting.enable = true;

    autosuggestion = {
      enable    = true;

      highlight = "fg = #ff00ff,bg = cyan,bold,underline";
    };

    autocd = true;

    zsh-abbr = {
      enable = true;

      abbreviations = {
        ".2"  = "cd ../..";
        ".3"  = "cd ../../..";
      };
    };

    antidote = {
      enable  = true;

      plugins = [
        "ohmyzsh/ohmyzsh"
        "ohmyzsh/ohmyzsh path:plugins/macos"
        "ohmyzsh/ohmyzsh path:plugins/git"
        "hlissner/zsh-autopair"
        "jeffreytse/zsh-vi-mode"
        "Aloxaf/fzf-tab"
      ];
    };
  };
}