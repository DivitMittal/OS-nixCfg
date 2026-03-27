{
  inputs,
  lib,
  ...
}: {
  perSystem = {
    pkgs,
    system,
    ...
  }: let
    ## Drop into a shell with a pre-built closure of packages in PATH
    mkEnvApp = name: packages: let
      env = pkgs.buildEnv {
        name = "${name}-env";
        paths = packages;
        pathsToLink = ["/bin" "/share"];
        ignoreCollisions = true;
      };
    in {
      type = "app";
      program = toString (pkgs.writeShellScript name ''
        export PATH="${env}/bin:$PATH"
        exec "''${SHELL:-${pkgs.bashInteractive}/bin/bash}"
      '');
    };

    ## Core TTY toolchain — shells, editors, multiplexers, navigation, vcs
    ttyPackages = lib.attrsets.attrValues {
      inherit
        (pkgs)
        ## Shells
        fish
        zsh
        ## Editors
        neovim
        vim
        ## Multiplexers
        tmux
        zellij
        ## Navigation / history
        atuin
        fzf
        zoxide
        carapace
        pay-respects
        television
        ## File tools
        bat
        eza
        fd
        ripgrep
        ripgrep-all
        ## VCS
        git
        gh
        lazygit
        jujutsu
        git-lfs
        delta
        ## Monitoring
        btop
        ## File manager
        yazi
        ## Prompt & fetch
        starship
        fastfetch
        ## Help / docs
        tealdeer
        glow
        ## Network
        aria2
        curl
        ## Data
        jq
        ;
    };

    ## AI toolchain — tty + AI CLIs + ai-nixCfg custom packages
    aiPackages =
      ttyPackages
      ++ lib.attrsets.attrValues {
        inherit
          (pkgs)
          claude-code
          aichat
          mods
          fabric-ai
          llm
          geminicommit
          ;
      }
      ++ lib.attrValues (inputs.ai-nixCfg.packages.${system} or {});

    ## Linux desktop — tty + Wayland compositor stack
    desktopPackages =
      ttyPackages
      ++ lib.attrsets.attrValues {
        inherit
          (pkgs)
          ## Wayland compositor
          niri
          ## Wayland utilities
          wayland-utils
          wl-clipboard
          xwayland-satellite
          ## Notifications
          dunst
          libnotify
          ## Screenshot / screen recording
          grim
          slurp
          wf-recorder
          ## App launcher
          fuzzel
          ## Status bar
          waybar
          ## Screen locker
          swaylock
          ## Misc Wayland tools
          wlr-randr
          kanshi
          ;
      };
  in {
    apps =
      {
        tty = mkEnvApp "tty" ttyPackages;
        ai = mkEnvApp "ai" aiPackages;
      }
      ## Desktop is Linux-only — compositor stack doesn't exist on Darwin
      // lib.optionalAttrs pkgs.stdenvNoCC.hostPlatform.isLinux {
        desktop = mkEnvApp "desktop" desktopPackages;
      };
  };
}
