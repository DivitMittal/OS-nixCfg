{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      calcurse
      #gcalcli
      #calcure
      ;
  };
}
