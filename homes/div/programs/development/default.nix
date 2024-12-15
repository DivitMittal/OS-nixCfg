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
      # android
      android-tools scrcpy

      # containerization
      docker lazydocker

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

    colima = if pkgs.stdenvNoCC.hostPlatform.isDarwin then pkgs-darwin.colima else null;
    luarocks = pkgs.luajitPackages.luarocks;
  };
}