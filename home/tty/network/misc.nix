{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      nmap # network scanner
      speedtest-go # speedtest cli
      bandwhich # bandwidth usage
      xh #httpie # http API client
      termscp # scp, ftp client
      gping # graphical ping alt
      dig # dns lookup
      dog # dig alt
      croc # file transfer
      ;
  };

  programs.aria2 = {
    enable = true;

    settings = {
      # listen-port = 60000;
      # dht-listen-port = 60000;
      # seed-ratio = 1.0;
      # max-upload-limit = "50K";
      ftp-pasv = true;
    };
  };
}
