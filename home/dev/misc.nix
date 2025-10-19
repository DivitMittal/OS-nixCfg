{
  pkgs,
  lib,
  config,
  hostPlatform,
  inputs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ## Android
      android-tools
      scrcpy
      ## General
      tokei
      ## Programming Languages
      #tree-sitter
      ## java
      #jdk gradle
      ## lua
      lua
      ## Rust
      cargo
      ## macOS
      xcodes
      ;

    leetcode-tui = inputs.leetcode-tui.packages.${hostPlatform.system}.default;
  };

  ## Rust
  home.sessionPath = lib.mkAfter ["${config.home.homeDirectory}/.cargo/bin"];
}
