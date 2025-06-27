{
  pkgs,
  lib,
  ...
}: {
  programs.visidata = {
    enable = true;
    package = pkgs.visidata;
  };

  home.packages = lib.attrsets.attrValues {
    inherit (pkgs) sc-im;
    inherit (pkgs.customPypi) euporie;
  };
}