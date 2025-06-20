{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      nmap
      speedtest-go
      bandwhich
      xh #httpie
      termscp
      gping
      dog
      dig
      croc
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
