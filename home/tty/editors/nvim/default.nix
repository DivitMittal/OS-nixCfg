{ pkgs, ... }:

{
  # programs.neovim = {
  #   enable = true;
  #   package = pkgs.neovim-unwrapped;
  #
  #   defaultEditor = true; # Sets the EDITOR sessionVariable
  # };
  programs.nvchad = {
    enable = true;
    extraPackages = builtins.attrValues {
      inherit(pkgs)
        vscode-langservers-extracted
        nixd alejandra
        emmet-language-server
      ;
      bash = pkgs.nodePackages.bash-language-server;
      python = pkgs.python3.withPackages(ps: with ps; [ python-lsp-server flake8 ]);
    };
    backup = false;
  };

  home.sessionVariables.VISUAL = "nvim";
  programs.fish.shellAbbrs.nv = { expansion = "nvim"; position = "command"; };
  programs.zsh.zsh-abbr.abbreviations.nv = "nvim";
}