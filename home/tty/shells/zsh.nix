{
  pkgs,
  lib,
  hostPlatform,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;

    dotDir = "${config.xdg.configHome}/zsh";
    history = {
      extended = false; # save timestamps as well
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      path = "$ZDOTDIR/.zsh_history";
      share = true;
    };
    defaultKeymap = null;

    autocd = true;
    zsh-abbr = {
      enable = true;
      abbreviations = {
        ".2" = "../..";
        ".3" = "../../..";
      };
    };

    enableCompletion = false;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = false;
    completionInit = true;
    antidote = {
      enable = true;
      package = pkgs.antidote;

      plugins =
        [
          "hlissner/zsh-autopair"
          "jeffreytse/zsh-vi-mode"

          # Add core plugins that make Zsh a bit more like Fish
          "zsh-users/zsh-completions path:src kind:fpath"
          "zsh-users/zsh-autosuggestions"
          "zsh-users/zsh-history-substring-search"
          "zdharma-continuum/fast-syntax-highlighting"
        ]
        ++ lib.lists.optionals hostPlatform.isDarwin [
          # Oh My Zsh plugins
          "getantidote/use-omz"
          "ohmyzsh/ohmyzsh path:plugins/brew"
          "ohmyzsh/ohmyzsh path:plugins/macos"
        ];
    };
  };
}
