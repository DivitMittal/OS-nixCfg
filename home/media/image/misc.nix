{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit(pkgs)
      #chafa
      imagemagick
      exif # metadata
    ;
  };
}