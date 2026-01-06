{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.tidalcycles-nix.homeManagerModules.default
  ];

  home.packages = lib.attrsets.attrValues {
    librescore = pkgs.writeShellScriptBin "dl-librescore" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx dl-librescore@latest "$@"
    '';
  };

  programs.tidalcycles = {
    enable = true;

    # Use standard profile (recommended)
    boot.profile = "standard";

    # SuperCollider configuration
    supercollider = {
      enable = true;
      package = pkgs.brewCasks.supercollider;
    };

    # SuperDirt configuration
    superdirt.enable = true;
  };
}
