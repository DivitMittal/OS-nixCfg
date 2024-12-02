{ pkgs, ... }:

{
  imports = [
    ./email
    ./weechat
    ./btop.nix
  ];

  home.packages = with pkgs; [
    ttyper
    bandwhich
  ];

  programs.spotify-player = {
    enable = true;
    package = pkgs.spotify-player;

    settings = {
      enable_media_control = true;
      enable_notify = false;
      device = {
        name = "spotify-tui";
        device_type = "MacBook";
        volume = 50;
        bitrate = 320;
        audio_cache = true;
        normalization = false;
        autoplay = true;
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