{ pkgs, ... }:

{
  imports = [
    ./python
    ./cloud.nix
    ./js.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      # android
      android-tools scrcpy

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