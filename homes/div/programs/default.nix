{ pkgs, ... }:

{
  imports = [
    ./browsers
    ./editors
    ./git
    ./multiplexers
    ./shells
    ./wezterm
    ./yazi
    ./aerc.nix
    ./atuin.nix
    ./bat.nix
    ./btop.nix
    ./eza.nix
    ./less.nix
    ./starship.nix
  ];

  programs = {
    fzf = {
      enable = true;
      package = pkgs.fzf;

      enableFishIntegration = false; enableBashIntegration = false; enableZshIntegration = false;
      defaultCommand        = "fd --hidden";
      defaultOptions        = [
        "--multi" "--cycle" "--border" "--height 50%"
        "--bind='right:select'" "--bind='left:deselect'" "--bind='tab:down'" "--bind='btab:up'"
        "--no-scrollbar" "--marker='*'" "--preview-window=wrap"
      ];
    };

    fd = {
      enable = true;
      package = pkgs.fd;

      hidden = true;
      ignores = [ ".git/" ];
    };

    zoxide = {
      enable = true;
      package = pkgs.zoxide;

      enableFishIntegration = true; enableZshIntegration  = true; enableBashIntegration = false;
      options = ["--cmd cd"];
    };

    thefuck = {
      enable = true;
      package = pkgs.thefuck;

      enableFishIntegration = true; enableZshIntegration = true; enableBashIntegration = false;
    };

    newsboat = {
      enable = true;
    };

    ripgrep = {
      enable = true;
      package = pkgs.ripgrep;

      arguments = [ "--max-columns-preview" "--colors=line:style:bold" ];
    };

    gh = {
      enable = true;
      package = pkgs.gh;
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
      package = pkgs.jq;

      colors = { null = "1;30"; false = "0;31"; true = "0;32"; numbers = "0;36"; strings = "0;33"; arrays = "1;35"; objects = "1;37"; };
    };

    tealdeer = {
      enable = true;

      settings = {
        display = { compact = false; use_pager = true; };
        updates = { auto_update = true; auto_update_interval_hours = 240; };
      };
    };

    # Disabled
    zellij = {
      enable = false;
      package = pkgs.zellij;

      enableFishIntegration = false; enableZshIntegration = false; enableBashIntegration = false;
    };
  };
}