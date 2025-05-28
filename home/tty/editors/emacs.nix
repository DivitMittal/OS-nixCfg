{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-doom-emacs-unstraightened.homeModule];

  programs.doom-emacs = {
    enable = true;
    doomDir = inputs.Emacs-Cfg;
    emacs = pkgs.emacs-nox;
  };

  # programs.emacs = {
  #   enable = true;
  #   package = pkgs.emacs-nox;
  # };
  #
  # xdg.configFile."doom" = {
  #   enable = true;
  #   source = ./doom;
  #   recursive = true;
  # };
}
