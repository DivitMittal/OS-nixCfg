{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    librescore = pkgs.writeShellScriptBin "dl-librescore" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx dl-librescore@latest "$@"
    '';
  };

  programs.tidalcycles = {
    enable = true;
    supercolliderPackage = pkgs.brewCasks.supercollider;
  };
}
