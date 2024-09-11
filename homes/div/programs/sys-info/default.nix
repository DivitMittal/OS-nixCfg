{ pkgs, ... }:

{
  imports = [
    ./fastfetch
    ./btop.nix
  ];

  home.packages = with pkgs; [
    # networking tools
    nmap speedtest-go
    bandwhich
  ];
}