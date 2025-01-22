{ pkgs, ... }:

{
  home.packages = builtins.attrValues {
    inherit(pkgs)
      # AI
      aichat

      ttyper
      gcalcli
    ;
  };
}