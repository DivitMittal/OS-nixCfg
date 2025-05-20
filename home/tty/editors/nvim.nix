{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.nvchad4nix.homeManagerModule];
  # programs.neovim = {
  #   enable = true;
  #   package = pkgs.neovim-unwrapped;
  #
  #   defaultEditor = true; # Sets the EDITOR sessionVariable
  # };
  programs.nvchad = {
    enable = true;
    extraPackages = lib.attrsets.attrValues {
      ## General
      inherit (pkgs.nodePackages) prettier;
      inherit (pkgs) vscode-langservers-extracted;
      inherit
        (pkgs)
        ## Lua
        stylua
        ## Nix
        nixd
        alejandra
        ## C/C++
        clang-tools
        ;
      ## Shell
      inherit (pkgs.nodePackages) bash-language-server;
      inherit (pkgs) shfmt;
      ## Python
      python = pkgs.python3.withPackages (ps:
        with ps; [
          python-lsp-server
          flake8
          black
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