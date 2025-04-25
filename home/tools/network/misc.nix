{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      nmap
      speedtest-go
      bandwhich
      httpie
      dig
      ;
  };
}
