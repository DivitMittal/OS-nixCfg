{ pkgs, ... }:

{
  imports = [
    ./admin
    ./file
    ./network
    ./pagers
    ./vcs
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