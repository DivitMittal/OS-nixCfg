{ config, pkgs, pkgs-darwin, lib, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  home.packages = builtins.attrValues {
    pipx = if isDarwin then pkgs-darwin.pipx else pkgs.pipx;
    micromamba = pkgs.micromamba;
  };

  # pip
  programs.fish.shellAliases = {
    pip-uninstall-all = "pip freeze | cut -d '@' -f1 | xargs pip uninstall -y";
    pipx-ultimate     = "pipx upgrade-all; pipx list --short 1> ${config.paths.currentHomeCfg}/programs/development/python/pipx.bak.txt";
  };

  # micromamba
  home.file.condarc = {
    source = ./.condarc;
    target = "${config.home.homeDirectory}/.condarc";
  };

  programs.fish.shellInitLast = lib.mkAfter ''
    # mamba initialize
    set -gx MAMBA_EXE "${config.home.profileDirectory}/bin/micromamba"
    set -gx MAMBA_ROOT_PREFIX "${config.home.homeDirectory}/.local/share/micromamba/"
    $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
  '';
}