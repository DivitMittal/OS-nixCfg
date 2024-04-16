_:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    history = {
      extended              = false; # save timestamps as well
      expireDuplicatesFirst = true; ignoreAllDups = true;
      path                  = "$ZDOTDIR/.zsh_history";
    };
    defaultKeymap = null;

    zsh-abbr = {
      enable = true;
      abbreviations = {
        ".2"  = "cd ../..";
        ".3"  = "cd ../../..";
        gits  = "git status";
        gitph = "git push";
        gitpl = "git pull";
        gitf  = "git fet ch";
        gitc  = "git commit";
        nv    = "nvim";
      };
    };

    autosuggestion = {
      enable    = true;
      highlight = "fg = #ff00ff,bg = cyan,bold,underline";
    };

    autocd        = true;

    antidote = {
      enable  = true;
      plugins = [
        "jeffreytse/zsh-vi-mode"
        "ohmyzsh/ohmyzsh" "ohmyzsh/ohmyzsh path:plugins/macos" "ohmyzsh/ohmyzsh path:plugins/git"
        "hlissner/zsh-autopair"
      ];
    };
  };
}