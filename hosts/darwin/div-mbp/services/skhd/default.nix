{ pkgs, ... }:

{
  services.skhd = {
    enable = true;
    package = pkgs.skhd;

    skhdConfig = builtins.readFile ./skhdrc;
  };
}