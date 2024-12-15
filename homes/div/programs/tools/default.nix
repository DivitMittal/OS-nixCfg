{ pkgs, ... }:

{
  imports = [
    ./network
    ./vcs
    ./btop.nix
    ./privacy.nix
  ];

  home.packages = builtins.attrValues {
    inherit(pkgs)
      # AI
      aichat

      ttyper
    ;
  };

}