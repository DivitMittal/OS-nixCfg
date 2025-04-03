{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ouch # archives
      hexyl # binary & misc.
      glow # markdown

      ## Documents
      pandoc
      poppler # PDFs
      rich-cli # CSVs, TSVs, XLSXs
      # tectonic-unwrapped # LaTeX
      ;
  };
}
