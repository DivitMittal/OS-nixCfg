{ pkgs, pkgs-darwin, ... }:

{
  imports = [
    ./js.nix
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
      # android
      android-tools scrcpy

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

    luarocks = pkgs.luajitPackages.luarocks;
  };
}