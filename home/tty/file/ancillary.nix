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

      ;
    inherit (pkgs.nixosStable) rich-cli;
    inherit (pkgs.python313Packages) markitdown;
  };
}
