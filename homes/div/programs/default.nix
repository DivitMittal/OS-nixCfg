{ pkgs, ... }:

{
  imports = [
    ./shells
    ./git
    ./yazi
    ./btop.nix
    ./atuin.nix
    ./starship.nix
    ./vim.nix
    ./firefox.nix
  ];

  programs = {
    fzf = {
      enable                = true;
      enableFishIntegration = false; enableBashIntegration = false; enableZshIntegration = false;
      defaultCommand        = "fd --hidden";
      defaultOptions        = [
        "--multi" "--cycle" "--border" "--height 50%"
        "--bind='right:select'" "--bind='left:deselect'" "--bind='tab:down'" "--bind='btab:up'"
        "--no-scrollbar" "--marker='*'" "--preview-window=wrap"
      ];
    };

    eza = {
      enable                = true;
      enableFishIntegration = true; enableZshIntegration  = true; enableBashIntegration = false;
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

    zellij = {
      enable = true;
      enableFishIntegration = false; enableZshIntegration = false; enableBashIntegration = false;
    };

    zoxide = {
      enable                = true;
      enableFishIntegration = true; enableZshIntegration  = true; enableBashIntegration = false;
      options               = ["--cmd cd"];
    };

    thefuck = {
      enable = true;
      enableFishIntegration = true; enableZshIntegration = true; enableBashIntegration = false;
    };

    newsboat = {
      enable = true;
    };

    ripgrep = {
      enable = true;
      arguments = [ "--max-columns-preview" "--colors=line:style:bold" ];
    };

    emacs = {
      enable = true;
      package = pkgs.emacs-nox;
    };

    gh = {
      enable = true;
      extensions = with pkgs;[ gh-eco gh-dash ];
      gitCredentialHelper = {
        enable = true;
        hosts = [ "https://github.com" "https://gist.github.com" ];
      };
      settings = {
        git_protocol= "ssh";
        prompt= "enabled";  # interactivity in gh
        pager= "less";
        aliases = {
          co = "pr checkout";
        };
      };
    };

    aria2  = {
      enable = true;
      settings = {
        # listen-port = 60000;
        # dht-listen-port = 60000;
        # seed-ratio = 1.0;
        max-upload-limit = "50K";
        ftp-pasv = true;
      };
    };

    jq = {
      enable = true;
      colors = { null = "1;30"; false = "0;31"; true = "0;32"; numbers = "0;36"; strings = "0;33"; arrays = "1;35"; objects = "1;37"; };
    };

    tealdeer = {
      enable = true;
      settings = {
        display = { compact = false; use_pager = true; };
        updates = { auto_update = false; };
      };
    };
  };
}