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
      sd # sed alternative
      ;
  };
}
