{ pkgs, ... }:

{
  imports = [
    ./atuin.nix
    ./eza.nix
    ./starship.nix
  ];


  home.packages = with pkgs; [
    duf
    dust
    grc

    # learning to use
    mosh
  ];
}