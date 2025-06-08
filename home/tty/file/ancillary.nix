{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ouch # archives
      hexyl # binary & misc.

      ## Documents
      pandoc
      poppler # PDFs
      rich-cli # csv, ipynbs, md
      ;
  };
}