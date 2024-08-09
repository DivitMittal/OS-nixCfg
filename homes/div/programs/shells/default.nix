{ config, pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./zsh.nix
    ./bash.nix
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  home.shellAliases  = {
    pip-uninstall-all = "pip freeze | cut -d '@' -f1 | xargs pip uninstall -y";
  };
}