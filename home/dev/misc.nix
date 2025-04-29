{
  pkgs,
  lib,
  config,
  hostPlatform,
  ...
}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ## Android
      android-tools
      scrcpy
      ## Programming Languages
      #tree-sitter
      ## java
      #jdk gradle
      ## lua
      lua
      # Rust
      cargo
      ;

    vscode =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.visual-studio-code
      else pkgs.vscode;
  };

  home.sessionPath = lib.mkAfter ["${config.home.homeDirectory}/.cargo/bin"];
}