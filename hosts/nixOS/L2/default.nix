{ pkgs, ... }:

{
  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];
}