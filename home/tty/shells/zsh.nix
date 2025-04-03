{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;

    dotDir = ".config/zsh";
    history = {
      extended = false; # save timestamps as well
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      path = "$ZDOTDIR/.zsh_history";
      share = true;
    };
    defaultKeymap = null;

    enableCompletion = true;

    syntaxHighlighting.enable = true;

    autosuggestion = {
      enable = true;
      highlight = "fg = #ff00ff,bg = cyan,bold,underline";
    };

    autocd = true;

    zsh-abbr = {
      enable = true;
      abbreviations = {
        ".2" = "../..";
        ".3" = "../../..";
      };
    };

    antidote = {
      enable = true;
      plugins = [
        # omz
        "ohmyzsh/ohmyzsh"
        "ohmyzsh/ohmyzsh path:plugins/macos"
        "ohmyzsh/ohmyzsh path:plugins/git"

        "hlissner/zsh-autopair"
        "jeffreytse/zsh-vi-mode"
      ];
    };
  };
}
