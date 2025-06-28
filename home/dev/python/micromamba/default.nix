{
  lib,
  pkgs,
  config,
  ...
}: let
  enable = false;
in {
  home.packages = lib.mkIf enable (lib.mkAfter [pkgs.micromamba]);
  home.file.condarc = {
    inherit enable;
    source = ./.condarc;
    target = "${config.home.homeDirectory}/.condarc";
  };
  programs.fish.shellInitLast = lib.mkIf enable (lib.mkAfter ''
    # mamba initialize
    set -gx MAMBA_EXE "${config.home.profileDirectory}/bin/micromamba"
    set -gx MAMBA_ROOT_PREFIX "${config.home.homeDirectory}/.local/share/micromamba/"
    $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
  '');
}
