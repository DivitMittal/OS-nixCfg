{pkgs, ...}: {
  programs.bat = {
    enable = true;
    package = pkgs.bat;
    extraPackages = with pkgs.bat-extras; [batman];

    config = {
      pager = "less";
      map-syntax = [
        "*.ino:C++"
        ".ignore:Git Ignore"
        "*.jenkinsfile:Groovy"
        "*.props:Java Properties"
      ];
    };
  };

  home.shellAliases = {
    man = "batman";
    cat = "bat --paging=never";
  };
}