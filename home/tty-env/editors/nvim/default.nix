{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    defaultEditor = true; # Sets the EDITOR sessionVariable
  };
  home.sessionVariables.VISUAL = "nvim";

  programs.fish.shellAbbrs.nv = { expansion = "nvim"; position = "command"; };
  programs.zsh.zsh-abbr.abbreviations.nv = "nvim";

  xdg.configFile."nvim/lua" = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ./conf/lua;
    recursive = true;
  };

  xdg.configFile."nvim/init.lua" = {
    enable = true;
    source = ./conf/init.lua;
  };
}