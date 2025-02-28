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

  home.file.nvimConfig = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink (builtins.toPath "${config.paths.programs}/tty-env/editors/nvim/config");
    target = "${config.xdg.configHome}/nvim";
    recursive = true;
  };
}