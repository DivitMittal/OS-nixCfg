{
  pkgs,
  lib,
  ...
}: {
  environment.shells = builtins.attrValues {
    inherit
      (pkgs)
      bash
      zsh
      fish
      dash
      ;
  };

  environment = {
    variables = rec {
      LANG = "en_US.UTF-8";
      VISUAL = "vim";
      EDITOR = "${VISUAL}";
    };

    shellAliases = {
      ls = "env ls -aF";
      ll = "env ls -alHbhigUuS";
    };
  };

  programs = let
    inherit (lib) mkDefault;
  in {
    bash = {
      enable = mkDefault true;

      completion = {
        enable = false;
        package = pkgs.bash-completion;
      };
    };

    zsh = {
      enable = mkDefault true;

      enableBashCompletion = false;
      enableCompletion = false;
      enableGlobalCompInit = false;
      enableSyntaxHighlighting = false;

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

      vendor = {
        config.enable = true;
        completions.enable = true;
        functions.enable = true;
      };
    };
  };
}
