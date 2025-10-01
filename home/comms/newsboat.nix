{
  pkgs,
  hostPlatform,
  ...
}: {
  programs.newsboat = {
    enable = true;
    package =
      if hostPlatform.isDarwin
      then pkgs.darwinStable.newsboat
      else pkgs.nixosStable.newsboat;

    autoReload = true;
    browser = "open";

    urls = [
      {
        tags = ["tech"];
        title = "TechCrunch";
        url = "http://feeds.feedburner.com/TechCrunch/";
      }
      {
        tags = ["fin"];
        title = "WSJ";
        url = "https://feeds.a.dj.com/rss/RSSMarketsMain.xml";
      }
      {
        tags = ["tech"];
        title = "TerminalTroveNew";
        url = "https://terminaltrove.com/new.xml";
      }
      {
        tags = ["tech"];
        title = "TerminalTroveBlog";
        url = "https://terminaltrove.com/blog.xml";
      }
      {
        tags = ["tech"];
        title = "ServerFault SO";
        url = "https://serverfault.com/feeds";
      }
    ];
  };
}
