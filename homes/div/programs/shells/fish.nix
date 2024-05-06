{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    functions = {
      ya = {
        body = ''
          set tmp (mktemp -t "yazi-cwd.XXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (env cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';
      };
      cht = { body = ''curl -ssL "https://cheat.sh/$argv''; };
    };

    shellAliases = {
      ff = ''fastfetch --logo-type iterm --logo ${./assets/a-12.png} \
              --pipe false --title-color-user magenta --title-color-at blue --title-color-host red \
              --structure Title:OS:Kernel:Uptime:Display:Terminal:CPU:CPUUsage:GPU:Memory:Swap:LocalIP \
              --gpu-temp true --cpu-temp true --cpu-format "{1} @ {#4;35}{8}{#}" --gpu-format "{2} @ {#4;35}{4}{#}"'';

      ## package-managers ultimate aliases
      pipx-ultimate = "pipx upgrade-all; pipx list --short 1> ${config.home.homeDirectory}/sync-darwin/homes/${config.home.username}/misc/ref-txts/pipx_list.txt";
      gem-ultimate  = "sudo -v; and gem update; gem cleanup";
      brew-ultimate = "brew update; and brew upgrade; and brew autoremove; and brew cleanup -s --prune=0; and rm -rf (brew --cache)";
      ## other ultimate aliases
      apps-backup   = "env ls /Applications/ 1> ${config.home.homeDirectory}/sync-darwin/homes/${config.home.username}/misc/apps/apps_(date +%b%y).txt";
      mac-ultimate  = "sudo -v;and brew-ultimate; apps-backup";
    };

    shellAbbrs = {
      nv    = { expansion = "nvim"; position     = "anywhere";};
      ".2"  = { expansion = "cd ../.."; position = "anywhere";};
      ".3"  = { expansion = "cd ../../.."; position = "anywhere";};
      gits  = { expansion = "git status"; position = "command";};
      gitph = { expansion = "git push"; position = "command";};
      gitpl = { expansion = "git pull"; position = "command";};
      gitf  = { expansion = "git fetch"; position = "command";};
      gitc  = { expansion = "git commit"; position = "command";};
    };

    interactiveShellInit = ''
      # PatrickF1/fzf.fish plugin
      set -gx fzf_fd_opts --hidden
      set -gx fzf_preview_dir_cmd eza --all --color=always --icons=always --classify --group-directories-first --group --hyperlink --color-scale --color-scale-mode=gradient
      set -gx fzf_diff_highlighter delta --paging=never --width=20
      set -gx fzf_preview_file_cmd bat --style=numbers
      fzf_configure_bindings --variables=\ev --processes=\ep --git_status=\es --git_log=\el --history=\er --directory=\ef

      # fifc plugin
      set -gx fifc_editor nvim
      set -gx fifc_fd_opts --hidden
      set -gx fifc_eza_opts --all

      type -q fastfetch; and test "$TERM_PROGRAM" = "WezTerm"; and ff    # Run Fastfetch - fetch system info
    '';

    shellInitLast = ''
      # nix
      fish_add_path --move --prepend /nix/var/nix/profiles/default/bin
      fish_add_path --move --prepend /run/current-system/sw/bin
      fish_add_path --move --prepend /etc/profiles/per-user/${config.home.username}/bin
      fish_add_path --move --prepend ${config.home.profileDirectory}/bin

      # pyenv
      # pyenv init - | source
      # pyenv virtualenv-init - | source

      # >>> mamba initialize >>>
      # !! Contents within this block are managed by 'mamba init' !!
      set -gx MAMBA_EXE "/Users/div/.nix-profile/bin/micromamba"
      set -gx MAMBA_ROOT_PREFIX "/Users/div/.local/share/micromamba/"
      $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
      # <<< mamba initialize <<<
    '';

    plugins = [
      {
        name = "fisher";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "fisher";
          rev = "4.4.4";
          hash = "sha256-e8gIaVbuUzTwKtuMPNXBT5STeddYqQegduWBtURLT3M=";
        };
      }
    ];
  };

  home.file = {
    fishPlugins = {
      text = ''
        jorgebucaran/autopair.fish
        nickeb96/puffer-fish
        markcial/upto
        patrickf1/fzf.fish
        lengyijun/fc-fish
        edc/bass
        oh-my-fish/plugin-wttr
        oh-my-fish/plugin-osx
        divitmittal/fifc@bugfix
      '';
      target = "${config.xdg.configHome}/fish/fish_plugins";
    };
  };
}