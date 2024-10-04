{ pkgs, ... }:

{
  imports = [
    ./fastfetch.nix
    ./btop.nix
  ];

  home.packages = with pkgs; [
    # networking tools
    nmap speedtest-go
    bandwhich
  ];
}