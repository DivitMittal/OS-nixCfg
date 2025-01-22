{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ ov ];

  home.file.ov_config = {
    enable = true;
    source = ./config.yaml;
    target = "${config.xdg.configHome}/ov/config.yaml";
  };
}