{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-doom-emacs-unstraightened.homeModule];

  programs.doom-emacs = {
    enable = false;
    doomDir = inputs.Emacs-Cfg;
    emacs = pkgs.emacs-nox;
  };

  programs.emacs = {
    enable = false;
    package = pkgs.emacs-nox;
  };
  xdg.configFile."doom" = {
    enable = false;
    source = inputs.Emacs-Cfg;
    recursive = true;
  };
}
