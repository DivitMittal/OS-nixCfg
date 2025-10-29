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
      poppler # PDFs
      ;
  };
}
