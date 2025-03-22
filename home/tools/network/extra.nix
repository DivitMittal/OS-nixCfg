{ pkgs, ... }:

{
  home.packages = builtins.attrValues {
    inherit(pkgs)
      nmap speedtest-go
      bandwhich
      httpie dig
    ;
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
}