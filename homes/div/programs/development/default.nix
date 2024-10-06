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

      # cloud-platforms-cli
      google-cloud-sdk

      ## Programming Languages
      tree-sitter
      # java
      jdk gradle
      # rust
      cargo
      # lua
      lua
    ;

    colima = pkgs-darwin.colima;
    luarocks = pkgs.luajitPackages.luarocks;
  };
}