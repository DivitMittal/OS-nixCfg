{ pkgs, ... }:

{
  imports = [
    ./firefox
  ];

  home.packages = builtins.attrValues {
    inherit(pkgs)
      w3m
    ;
  };
}