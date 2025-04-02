{ pkgs, ... }:

{
  home.packages = builtins.attrValues {
    inherit(pkgs)
      #onlyoffice-desktopeditors
      alt-tab-macos
    ;
  };
}