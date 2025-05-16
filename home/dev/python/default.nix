{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      uv
      ;
  };

  ## pip
  programs.fish.shellAliases = {
    pip-uninstall-all = "pip3 freeze | cut -d '@' -f1 | xargs pip3 uninstall -y";
  };

  ## pipx
  # home.packages = lib.mkAfter [ pkgs.pipx ];
  # programs.fish.shellAliases.pipx-ultimate = "pipx upgrade-all; pipx list --short 1> $OS_NIXCFG/home/dev/python/pipx.bak.txt";

  ## micromamba
  # home.packages = lib.mkAfter [ pkgs.micromamba ];
  # home.file.condarc = {
  #   source = ./.condarc;
  #   target = "${config.home.homeDirectory}/.condarc";
  # };
  # programs.fish.shellInitLast = lib.mkAfter ''
  #   # mamba initialize
  #   set -gx MAMBA_EXE "${config.home.profileDirectory}/bin/micromamba"
  #   set -gx MAMBA_ROOT_PREFIX "${config.home.homeDirectory}/.local/share/micromamba/"
  #   $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
  # '';
}
