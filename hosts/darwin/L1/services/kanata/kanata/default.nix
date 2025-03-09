{ pkgs, ... }:

{
  imports = [
    ./kanata.nix
  ];

  services.kanata = {
    enable = false;
    package = pkgs.kanata-with-cmd;
  };
}