{
  pkgs,
  lib,
  hostPlatform,
  inputs,
  ...
}: {
  home.packages =
    lib.attrsets.attrValues {
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
        ## macOS
        xcodes
        ;
      leetcode-tui = inputs.leetcode-tui.packages.${hostPlatform.system}.default;
    }
    ++ lib.optionals hostPlatform.isDarwin [
      (lib.custom.mkZbxBin "unxip")
    ];
}
