{ pkgs, ... }:

{
  imports = [
    ./email
    ./spicetify
    ./weechat
    ./bw.nix
    ./rclone.nix
  ];

  home.packages = builtins.attrValues {
    aichat = pkgs.aichat;
    ttyper = pkgs.ttyper;
  };

  programs.thefuck = {
    enable = true;
    package = pkgs.thefuck;

    enableFishIntegration = true; enableZshIntegration = true; enableBashIntegration = false;
  };

  programs.aria2  = {
    enable = true;

    settings = {
      # listen-port = 60000;
      # dht-listen-port = 60000;
      # seed-ratio = 1.0;
      # max-upload-limit = "50K";
      ftp-pasv = true;
    };
  };

  programs.tealdeer = {
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

  programs.newsboat = {
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
}