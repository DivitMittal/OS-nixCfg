{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  imports = [inputs.nvchad4nix.homeManagerModule];

  programs.nvchad = {
    enable = true;
    extraPackages = lib.attrsets.attrValues {
      ## General
      inherit (pkgs.nodePackages) prettier;
      inherit
        (pkgs)
        ## Lua
        stylua
        ## Nix
        nixd
        alejandra
        ## C/C++
        clang-tools
        ## Collection
        vscode-langservers-extracted
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

  programs.fish.shellAbbrs.nv = mkIf config.programs.fish.enable {
    expansion = "nvim";
    position = "command";
  };
  programs.zsh.zsh-abbr.abbreviations.nv = mkIf config.programs.zsh.enable "nvim";

  # programs.neovim = {
  #   enable = false;
  #   package = pkgs.neovim-unwrapped;
  #
  #   defaultEditor = true; # Sets the EDITOR sessionVariable
  # };
}
