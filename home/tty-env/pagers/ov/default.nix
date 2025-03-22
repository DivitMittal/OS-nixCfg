{ pkgs, ... }:

{
  home.packages = [ pkgs.ov ];

  xdg.configFile."ov/config.yaml" = {
    enable = true;
    source = ./config.yaml;
  };
}