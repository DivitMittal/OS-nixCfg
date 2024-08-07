{ config, ... }:

{
  programs.fish.shellAbbrs.nv = { expansion = "nvim"; position = "command";};
  programs.zsh.zsh-abbr.abbreviations.nv = "nvim";

  home.file.nvim = {
    source = ./custom;
    target = "${config.xdg.configHome}/nvim/lua/custom";
    recursive = true;
  };
}