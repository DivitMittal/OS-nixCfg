{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ouch # archives
      hexyl # binary & misc.

      ## Documents
      pandoc
      poppler # PDFs
      # tectonic-unwrapped # LaTeX
      ;
    inherit(pkgs.python313Packages) rich;
  };
}