{ pkgs, self, config, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    defaultEditor = true; # Sets the EDITOR sessionVariable
  };
  home.sessionVariables.VISUAL = "nvim";

  programs.fish.shellAbbrs.nv = { expansion = "nvim"; position = "command"; };
  programs.zsh.zsh-abbr.abbreviations.nv = "nvim";

  xdg.configFile."nvim" = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink (self + /homes/programs/tty-env/editors/nvim/conf);
    recursive = true;
  };
}