{ pkgs, ... }:

{
  imports = [
    ./../common
    ./apps
    ./defaults
    ./services
    ./users.nix
  ];

  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];
}