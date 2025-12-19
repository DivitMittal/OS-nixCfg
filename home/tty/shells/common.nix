{config, ...}: {
  home.sessionVariables = let
    HOME = "${config.home.homeDirectory}";
    local = "${HOME}/.local";
  in {
    inherit HOME;
    XDG_CONFIG_HOME = "${config.xdg.configHome}";
    XDG_CACHE_HOME = "${HOME}/.cache";
    XDG_STATE_HOME = "${local}/state";
    XDG_DATA_HOME = "${local}/share";
    BIN_HOME = "${local}/bin";
    LANG = "${config.home.language.base}";
    VISUAL = "${config.home.sessionVariables.EDITOR}";
  };

  home.shellAliases = {
    dt = "builtin cd ${config.home.homeDirectory}/Desktop/";
    dl = "builtin cd ${config.home.homeDirectory}/Downloads/";
  };

  home.sessionPath = [
    "${config.home.sessionVariables.BIN_HOME}"
  ];
}
