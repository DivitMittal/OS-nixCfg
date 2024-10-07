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