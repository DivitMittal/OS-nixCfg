{ config, pkgs, ... }:

{
 nix = {
   package     = pkgs.nix;
   checkConfig = true;
 };
 nixpkgs = {
   config = {
     allowBroken = true; allowUnfree = true; allowUnsupportedSystem = true; allowInsecure = true;
   };
 };

 home = {
  username              = "div"; homeDirectory = "/Users/div";
  preferXdgDirectories  = true;
  extraOutputsToInstall = ["doc" "info" "devdoc"];
  stateVersion          = "23.11";
 };

 home.packages = with pkgs;[
  ## Terminal Environment
  grc (fastfetch.overrideAttrs { preBuild = lib.optionalString stdenv.isDarwin "export MACOSX_DEPLOYMENT_TARGET=14.0";})
  fd duf dust hexyl ouch ov # Modern altenatives
  bitwarden-cli rclone # CLI tools
  android-tools  # Developer tools
  pipx spicetify-cli # plugin/package/module managers
  nmap speedtest-go bandwhich # networking tools
  pandoc poppler chafa imagemagick ffmpeg # file/data format
  colima lima docker # Virtualization & Containerization
  weechat # IRC
  duti blueutil # macOS utils
  ## custom scripts
  (pkgs.writeShellScriptBin "my-hello" ''echo "Hello, ${config.home.username}!"'')
 ];

 home.sessionPath = [
  "$HOME/.local/bin"
  # "$HOME/.config/emacs/bin"
  # "/Application/Floorp.app/Contents/MacOS"
  "/System/Library/PrivateFrameworks/Apple80211.framework/Resources" #Airport Utility
 ];

 home.sessionVariables = {
  LESSOPEN = "|${pkgs.lesspipe}/bin/lesspipe.sh %s"; LESSCOLORIZER = "bat";
  SCREENRC = "$HOME/.config/screen/screenrc";
 };

 home.shellAliases  = {
   man               = "batman";
   cat               = "bat --paging=never";
   cleanup-DS        = "sudo find . -type f -name '*.DS_Store' -ls -delete";
   empty-trash       = "bash -c 'sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sudo rm -rfv /private/tmp/*.log'";
   pip-uninstall-all = "pip freeze | cut -d '@' -f1 | xargs pip uninstall -y";
   lt                = "eza --tree --level=2 $eza_params";
   ll                = "eza -albhHigUuS -m@ $eza_params | ov -H1";
 };

 home.file = {
   # ".local/bin/doom".source = .config/emacs/bin/doom;
   # ".local/bin/floorp".source = /Application/Floorp.app/Contents/MacOS/floorp;
   "${config.xdg.configHome}/screen/screenrc".source = ./file/screenrc;

   # ".gradle/gradle.properties".text = ''
   #   org.gradle.console=verbose
   #   org.gradle.daemon.idletimeout=3600000
   # '';
 };

 editorconfig = {
  enable = true;
  # top-most editorconfig
  settings = {
   "*" = {
    charset = "utf-8";
    end_of_line = "lf";
    trim_trailing_whitespace = true;
    insert_final_newline = false;
    max_line_width = 200;
    indent_style = "space";
    indent_size = 2;
    spelling_language = "en-US";
   };
  };
 };

 programs = {

  home-manager = {
   enable = true;
  };

  fish = {
   enable = true;
   shellAliases = {
    ff = ''fastfetch --logo-type iterm --logo $HOME/Sync-macOS/assets/a-12.png \
           --pipe false --title-color-user magenta --title-color-at blue --title-color-host red \
           --structure Title:OS:Kernel:Uptime:Display:Terminal:CPU:CPUUsage:GPU:Memory:Swap:LocalIP \
           --gpu-temp true --cpu-temp true --cpu-format "{1} @ {#4;35}{8}{#}" --gpu-format "{2} @ {#4;35}{4}{#}"'';


    ## package-managers ultimate aliases
    pipx-ultimate = "pipx upgrade-all; pipx list --short 1> ~/Sync-macOS/etc/ref-txts/pipx_list.txt";
    gem-ultimate  = "sudo -v; and gem update; gem cleanup";
    brew-ultimate = "brew update; and brew upgrade; and brew autoremove; and brew cleanup -s --prune=0; and rm -rf (brew --cache)";
    ## other ultimate aliases
    apps-backup   = "env ls /Applications/ 1> $HOME/Sync-macOS/etc/ref-txts/apps_(date +%b%y).txt";
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
    fish_add_path --move --prepend /etc/profiles/per-user/div/bin
    fish_add_path --move --prepend $HOME/.nix-profile/bin

    # pyenv
    pyenv init - | source
    pyenv virtualenv-init - | source
   '';
  };

  zsh = {
   enable = true;
   dotDir = ".config/zsh";
   history = {
    extended              = false; # save timestamps as well
    expireDuplicatesFirst = true;
    ignoreAllDups         = true;
    path                  = "$ZDOTDIR/.zsh_history";
   };

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
   defaultKeymap = null;
   antidote = {
    enable  = true;
    plugins = [
    "jeffreytse/zsh-vi-mode"
    "ohmyzsh/ohmyzsh" "ohmyzsh/ohmyzsh path:plugins/macos" "ohmyzsh/ohmyzsh path:plugins/git"
    "hlissner/zsh-autopair"
    ];
   };
  };

  git = {
   enable = true;
   userName   = "Divit Mittal";
   userEmail  = "64.69.76.69.74.m@gmail.com";
   attributes = import ./programs/git/gitAttributes.nix;
   ignores    = import ./programs/git/gitIgnore.nix;
   aliases = {
    last       = "log -1 HEAD";
    graph      = "log --graph --all --full-history --pretty=format:'%Cred%h%Creset %ad %s %C(yellow)%d%Creset %C(bold blue)<%an>%Creset' --date=short";
    unstage    = "restore --staged";
    clean-U-dr = "clean -d -x f -n";
    clean-U    = "clean -d -x -f";
   };
   delta = {
    enable = true;
   };
   extraConfig = import ./programs/git/gitConfig.nix;
  };

  fzf = {
   enable                = true;
   enableFishIntegration = false;
   defaultCommand        = "fd --hidden";
   defaultOptions        = [
    "--multi" "--cycle" "--border" "--height 50%"
    "--bind='space:toggle'" "--bind='tab:down'" "--bind='btab:up'"
    "--no-scrollbar" "--marker='*'" "--preview-window=wrap"
   ];
  };

  eza = {
   enable                = true;
   enableFishIntegration = true;
   enableZshIntegration  = true;
   extraOptions  = ["--all" "--classify" "--icons=always" "--group-directories-first" "--color=always" "--color-scale" "--color-scale-mode=gradient" "--hyperlink"];
  };

  bat = {
   enable        = true;
   extraPackages = with pkgs.bat-extras; [ batman ];
   config = {
    pager      = "less";
    map-syntax = ["*.ino:C++" ".ignore:Git Ignore" "*.jenkinsfile:Groovy" "*.props:Java Properties"];
   };
  };

  yazi = {
   enable = true;
   enableFishIntegration = true;
   enableZshIntegration = true;
  };

  zellij = {
   enable = true;
   enableFishIntegration = false;
   enableZshIntegration = false;
  };

  btop = {
   enable = true;
   settings = import ./programs/btop.nix;
  };

  starship = {
   enable                = true;
   enableFishIntegration = true; enableZshIntegration  = true;
   settings              = import ./programs/starship.nix;
  };

  atuin = {
   enable                = true;
   enableFishIntegration = true; enableZshIntegration  = true;
   settings              = import ./programs/atuin.nix;
  };

  zoxide = {
   enable                = true;
   enableFishIntegration = true; enableZshIntegration  = true;
   options               = ["--cmd cd"];
  };

  thefuck = {
   enable = true;
   enableFishIntegration = true; enableZshIntegration = true;
  };

  newsboat = {
   enable = true;
  };

  tmux = {
   enable = true;
  };

  ripgrep = {
   enable = true;
   arguments = [ "--max-columns-preview" "--colors=line:style:bold" ];
  };

  emacs = {
   enable = true;
  };

  neovim = {
   enable = true;
  };

  gh = {
   enable = true;
   extension = with pkgs;[ gh-eco gh-dash ];
   gitCredentialHelper = {
    enable = true;
    hosts = [ "https://github.com" "https://gist.github.com" ];
   };
   settings = {
    # What protocol to use when performing git operations. Supported values: ssh, https
    git_protocol= "https";
    # When to interactively prompt. This is a global config that cannot be overridden by hostname. Supported values= enabled, disabled
    prompt= "enabled";
    # A pager program to send command output to, e.g. "less". Set the value to "cat" to disable the pager.
    pager= "less";
    # Aliases allow you to create nicknames for gh commands
    aliases = {
     co = "pr checkout";
    };
    # The path to a unix socket through which send HTTP connections. If blank, HTTP traffic will be handled by net/http.DefaultTransport.
    # http_unix_socket =
    # What web browser gh should use when opening URLs. If blank, will refer to environment.
    # browser =
    # version = "1"
   };
  };

  aria2  = {
   enable = true;
   settings = {
    # listen-port = 60000;
    # dht-listen-port = 60000;
    # seed-ratio = 1.0;
    # max-upload-limit = "50K";
    ftp-pasv = true;
   };
  };

  jq = {
   enable = true;
   colors = {
    null    = "1;30";
    false   = "0;31";
    true    = "0;32";
    numbers = "0;36";
    strings = "0;33";
    arrays  = "1;35";
    objects = "1;37";
   };
  };

  tealdeer = {
   enable = true;
   settings = {
    display = {
     compact = false;
     use_pager = true;
    };
    updates = {
     auto_update = false;
    };
   };
  };

  navi = {
   enable = true;
   enableFishIntegration = true; enableZshIntegration = true;
  };

 };
}