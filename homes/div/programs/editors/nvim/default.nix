{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    defaultEditor = true;
  };

  programs.fish.shellAbbrs.nv = { expansion = "nvim"; position = "command"; };
  programs.zsh.zsh-abbr.abbreviations.nv = "nvim";

  home.sessionVariables.VISUAL = "nvim";

  home.file.NvChad = {
    source = ./custom;
    target = "${config.xdg.configHome}/nvim/lua/custom";
    recursive = true;
  };
}