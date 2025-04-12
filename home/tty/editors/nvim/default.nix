{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvchad4nix.homeManagerModules.nvchad
  ];
  # programs.neovim = {
  #   enable = true;
  #   package = pkgs.neovim-unwrapped;
  #
  #   defaultEditor = true; # Sets the EDITOR sessionVariable
  # };
  programs.nvchad = {
    enable = true;
    extraPackages = builtins.attrValues {
      inherit
        (pkgs)
        ## LSPs
        vscode-langservers-extracted
        emmet-language-server
        typescript-language-server
        nixd
        ## Formatters
        alejandra
        shfmt
        stylua
        ## Both LSPs and Formatters
        clang-tools
        ;
      ## LSPs
      bash = pkgs.nodePackages.bash-language-server;
      ## Formatters
      inherit (pkgs.nodePackages) prettier;
      ## Both LSPs and Formatters
      python = pkgs.python3.withPackages (ps:
        with ps; [
          python-lsp-server
          flake8
          black # Formatter
        ]);
    };
    backup = false;
  };

  home.sessionVariables.VISUAL = "nvim";
  programs.fish.shellAbbrs.nv = {
    expansion = "nvim";
    position = "command";
  };
  programs.zsh.zsh-abbr.abbreviations.nv = "nvim";
}