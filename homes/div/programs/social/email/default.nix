{ pkgs, config, ... }:

{
  imports = [
    ./aerc
  ];

  home.file.oauth2 = {
    enable = true;
    source = ./mutt_oauth2.py;
    target = "${config.paths.binHome}/oauth2";
  };
}