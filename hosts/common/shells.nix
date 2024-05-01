_:

{
  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_DATA_HOME = "$HOME/.local/share";
    LANG = "en_US.UTF-8";
    EDITOR = "vim";
    VISUAL = "vim";
  };

  environment.shellAliases = {
    ls       = "env ls -aF";
    ll       = "env ls -alHbhigUuS";
    ed       = "ed -v -p ':'";
    showpath = ''echo $PATH | sed "s/ /\n/g"'';
    showid   = ''id | sed "s/ /\n/g"'' ;
  };
}