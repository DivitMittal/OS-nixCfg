{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ lua luajitPackages.luarocks ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    defaultEditor = true; # Sets the EDITOR sessionVariable
  };
  home.sessionVariables.VISUAL = "nvim";

  programs.fish.shellAbbrs.nv = { expansion = "nvim"; position = "command"; };
  programs.zsh.zsh-abbr.abbreviations.nv = "nvim";

  home.file.NvChad = {
    source = ./nvchad-custom;
    target = "${config.xdg.configHome}/nvim/lua";
    recursive = true;
  };
}