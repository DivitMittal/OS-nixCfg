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
        ## General
        tokei
        ## Programming Languages
        #tree-sitter
        ## java
        #jdk gradle
        ## lua
        lua
        ;
      leetcode-tui = inputs.leetcode-tui.packages.${hostPlatform.system}.default;
    }
    ++ lib.optionals hostPlatform.isDarwin [
      pkgs.xcodes
      (lib.custom.mkZbxBin "unxip")
    ];
}
