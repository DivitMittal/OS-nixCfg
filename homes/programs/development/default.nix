{ pkgs, config, lib, ... }:

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
      # lua
      lua
      # Rust
      cargo
    ;

    luarocks = pkgs.luajitPackages.luarocks;
  };

  home.sessionPath = lib.mkAfter [ "${config.home.homeDirectory}/.cargo/bin" ];
}