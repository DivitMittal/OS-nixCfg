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
      httpie
      dig
      termscp
      ;
  };
}
