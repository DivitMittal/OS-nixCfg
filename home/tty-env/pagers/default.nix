{ pkgs, ... }:

{
  imports = [
    ./ov
    ./bat.nix
    ./less.nix
  ];

  home.packages = builtins.attrValues {
    inherit(pkgs)
      glow # markdown pager
    ;
  };
}