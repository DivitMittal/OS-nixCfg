{ config, ... }:

{
  home.file.oauth2 = {
    enable = true;
    source = ./mutt_oauth2.py;
    target = "${config.home.sessionVariables.BIN_HOME}/oauth2";
  };
}