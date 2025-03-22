{ pkgs, ... }:

{
  home.packages = builtins.attrValues {
    inherit(pkgs)
      ttyper
      gcalcli
    ;
  };
}