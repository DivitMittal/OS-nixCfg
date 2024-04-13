{ pkgs, lib, inputs, ... }:

{
  environment.darwinConfig = "$HOME/sync-darwin/nix-darwin/flake.nix";
  services.nix-daemon.enable = true;  # Auto upgrade nix package and the daemon service.

  time.timeZone = "Asia/Calcutta";

  networking = {
    computerName         = "L1";
    hostName             = "div-mbp";
    knownNetworkServices = ["Wi-Fi"];
    dns                  = ["1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001"];
  };

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.CustomUserPreferences = import ./system/macOS_defaults.nix;

  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null; # Set Git commit hash for darwin-version.
    checks = {
      verifyBuildUsers = true; verifyNixChannels = true; verifyNixPath = true;
    };
    stateVersion = 4;                                                        # $ darwin-rebuild changelog
  };

  nix = {
    package  = pkgs.nix;
    settings = {
      "experimental-features" = ["nix-command" "flakes"];
      "use-xdg-base-directories" = false;
      trusted-users = ["root" "div"];
      auto-optimise-store = true;
    };
  };

  nixpkgs = {
    hostPlatform = "x86_64-darwin";
    config = {
      allowBroken = true; allowUnfree = true; allowUnsupportedSystem = true; allowInsecure = true;
    };
  };

  environment = {
    systemPackages = with pkgs;[
      nixfmt-rfc-style # Nix goodies
      bashInteractive zsh dash fish babelfish # shells
      ed gnused nano vim # editors
      bc binutils diffutils findutils inetutils gnugrep gawk groff which gzip gnupatch screen gnutar indent gnumake wget (lib.hiPrio gcc) # GNU
      (uutils-coreutils.override {prefix = "";}) # GNU-alt
      curl git less ## Other
    ];
    extraOutputsToInstall = [ "doc" "info" "devdoc" ];
  };

  documentation = {
    enable      = true;
    doc.enable  = true; info.enable = true; man.enable  = true;
  };

  fonts = {
    fontDir.enable = true;
    fonts          = with pkgs;[(nerdfonts.override {fonts = ["CascadiaCode"];})];
  };

  environment = {
    shells = with pkgs;[bashInteractive zsh dash fish];
    loginShell = "${pkgs.zsh}";
  };

  environment.variables = {
    XDG_CONFIG_HOME       = "$HOME/.config"     ; XDG_CACHE_HOME = "$HOME/.cache";
    XDG_STATE_HOME        = "$HOME/.local/state"; XDG_DATA_HOME  = "$HOME/.local/share";
    LANG                  = "en_US.UTF-8";
    ARCHFLAGS             = "-arch x86_64";
    HOMEBREW_NO_ENV_HINTS = "1";
  };

  environment.shellAliases = {
    dt       = "env cd $HOME/Desktop/";
    dl       = "env cd $HOME/Downloads";
    ls       = "env ls -aF";
    ll       = "env ls -alHbhigUuS";
    v        = "vim";
    ed       = "ed -v -p ':'";
    showpath = ''echo $PATH | sed "s/ /\n/g"'';
    showid   = ''id | sed "s/ /\n/g"'';
  };

  users = {
    users.div = {
      description = "Divit Mittal";
      home        = "/Users/div";
      shell       = pkgs.fish;
      packages    = with pkgs;[
       # macOS utils
      ruby duti blueutil
      yabai skhd kanata-with-cmd
      ];
    };
  };

  programs = {
    nix-index.enable = true;
    man.enable       = true; info.enable      = true;

    bash = {
      enable               = true;
      interactiveShellInit = ''
        # [ -z "$PS1" ] && return                                             # exit if running non-interactively (handled by nix-darwin)
        PS1='%F{cyan}%~%f %# '
        # set -o vi                                                           # vi keybindings

        export BASH_SILENCE_DEPRECATION_WARNING=1
        export BADOTDIR="$HOME/.config/bash"
        export HISTFILE=''${BADOTDIR:-$HOME}/.bash_history

        # shopt -s checkwinsize                                               # check window size after every command       (handled by nix-darwin)
        # [ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM" # source a specific bashrc for Apple Terminal (handled by nix-darwin)
      '';
    };

    zsh = {
      enable                  = true;
      # enableSyntaxHighlighting = true;
      # enableCompletion         = true;
      # enableFzfCompletion      = true;
      # enableFzfGit             = true;
      # enableFzfHistory         = true;
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

    fish = {
      enable       = true;
      useBabelfish = true;
      vendor = {
        config.enable = true;
        completions.enable = true;
        functions.enable = true;
      };
      shellInit = ''
        set -g fish_greeting
      '';
      interactiveShellInit = ''
        set -g fish_greeting
        set -g fish_vi_force_cursor 1
        set -g fish_cursor_default block
        set -g fish_cursor_visual block
        set -g fish_cursor_insert line
        set -g fish_cursor_replace_one underscore
      '';
    };
  };

  services = {
## TODO add kanata to sudoers.d
    yabai = {
      enable = true;
      enableScriptingAddition = true;
      config      = import ./services/yabai.nix { configType = "config"; };
      extraConfig = import ./services/yabai.nix { configType = "extraConfig"; };
    };
    skhd = {
      enable = true;
      skhdConfig = import ./services/skhd.nix;
    };
  };

  # environment.etc."sudoers.d/kanata".source = pkgs.runCommand "sudoers-kanata" {}
  # ''
  #       YABAI_BIN="${kanata-with-cmd}/bin/yabai"
  #       SHASUM=$(sha256sum "$YABAI_BIN" | cut -d' ' -f1)
  #       cat <<EOF >"$out"
  #       %admin ALL=(root) NOPASSWD: sha256:$SHASUM $YABAI_BIN --load-sa
  #       EOF
  # ''

  homebrew = import ./homebrew.nix;
}