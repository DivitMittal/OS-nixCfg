{ pkgs, pkgs-darwin, ... }:

{
  imports = [
    ./javascript.nix
    ./python
  ];

  programs.awscli = {
    enable = true;
    package = pkgs.awscli2;

    settings = {
      "default" = {
        region = "ap-south-1";
        output = "json";
      };
    };
  };

  home.packages = builtins.attrValues {
    inherit (pkgs)
      # networking
      httpie

      # android
      android-tools

      # containerization
      docker

      # java
      jdk gradle

      # cloud-platforms-cli
      google-cloud-sdk
    ;

    colima = pkgs-darwin.colima;
  };
}