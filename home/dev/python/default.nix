{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      uv #pipx
      ;
  };

  ## pip
  programs.fish.shellAliases = {
    pip-uninstall-all = "pip3 freeze | cut -d='@' -f1 | xargs pip3 uninstall -y";
  };

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
