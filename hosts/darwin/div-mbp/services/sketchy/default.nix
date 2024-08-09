{ pkgs, ... }:

{
  services.sketchybar = {
    enable = false;
    extraPackages = with pkgs;[ lua ];
  };
}