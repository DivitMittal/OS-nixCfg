{ config, ... }:

{
  home.sessionVariables = rec {
    HOME            = "${config.home.homeDirectory}";
    XDG_CONFIG_HOME = "${HOME}/.config";
    XDG_CACHE_HOME  = "${HOME}/.cache";
    XDG_STATE_HOME  = "${HOME}/.local/state";
    XDG_DATA_HOME   = "${HOME}/.local/share";
    BIN_HOME        = "${HOME}/.local/bin";
    LANG            = "en_US.UTF-8";
    VISUAL          = "nvim";
    EDITOR          = "${VISUAL}";
  };

  home.sessionPath = [
    "${config.home.sessionVariables.BIN_HOME}"
  ];
}