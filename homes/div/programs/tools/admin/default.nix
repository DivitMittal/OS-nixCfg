{ pkgs, ... }:

{
  imports = [
    ./btop.nix
  ];

  home.packages = builtins.attrValues {
    inherit(pkgs)
      duf
      dust
    ;
  };
}