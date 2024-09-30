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

  home.file.NvChad = {
    enable = true;
    source = ./nvchad-custom;
    target = "${config.xdg.configHome}/nvim/lua";
    recursive = true;
  };
}