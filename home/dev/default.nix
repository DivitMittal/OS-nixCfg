{ pkgs, config, lib, ... }:

{
  imports = lib.custom.scanPaths ./.;

  home.packages = builtins.attrValues {
    inherit (pkgs)
      ## Genreal
      just

      ## Android
      android-tools scrcpy

      ## Programming Languages
      tree-sitter
      # java
      jdk gradle
      # lua
      lua
      # Rust
      cargo
    ;

    luarocks = pkgs.luajitPackages.luarocks;
  };

  home.sessionPath = lib.mkAfter [ "${config.home.homeDirectory}/.cargo/bin" ];
}