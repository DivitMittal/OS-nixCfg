{ pkgs, ... }:

{
  imports = [
    ./browsers
    ./editors
    ./fastfetch
    ./git
    ./languages
    ./multiplexers
    ./pagers
    ./shells
    ./spicetify
    ./weechat
    ./wezterm
    ./yazi
    ./aerc.nix
    ./atuin.nix
    ./bat.nix
    ./btop.nix
    ./bw.nix
    ./eza.nix
    ./fzf.nix
    ./rclone.nix
    ./starship.nix
  ];

  programs = {
    mpv = {
      enable = true;
      package = pkgs.hello; # Installed via Homebrew instead

      bindings = {
        "n" = "seek -10";
        "i" = "seek +10";
      };

      config = {
        force-window = true;
      };
    };

    newsboat = {
      enable = true;

      autoReload = true;
      browser = "open";

      urls = [
        {
          tags = [ "tech" ];
          title = "TechCrunch";
          url = "http://feeds.feedburner.com/TechCrunch/";
        }
        {
          tags = [ "fin" ];
          title = "WSJ";
          url = "https://feeds.a.dj.com/rss/RSSMarketsMain.xml";
        }
      ];
    };

    fd = {
      enable = true;
      package = pkgs.fd;

      hidden = true; # creates shell alias
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

    ripgrep = {
      enable = true;
      package = pkgs.ripgrep;

      arguments = [ "-i" "--max-columns-preview" "--colors=line:style:bold" ];
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

      colors = {
        null = "1;30";
        false = "0;31";
        true = "0;32";
        numbers = "0;36";
        strings = "0;33";
        arrays = "1;35";
        objects = "1;37"; };
    };

    tealdeer = {
      enable = true;

      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {
          auto_update = true;
          auto_update_interval_hours = 240;
        };
      };
    };
  };
}