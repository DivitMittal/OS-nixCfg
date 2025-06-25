{
  pkgs,
  lib,
  ...
}: {
  home.shellAliases = {
    ed = "${pkgs.ed}/bin/ed -v -p ':'";
  };

  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      sc-im #Spreadsheet calculator
      sd # sed alternative
      ;
  };

  programs.visidata = {
    enable = true;
    package = pkgs.visidata;
  };
}
