{
  pkgs,
  lib,
  hostPlatform,
  inputs,
  ...
}: let
  droid-m1 = pkgs.writeShellScriptBin "Droid-M1" ''
    mountpoint="$HOME/mnt/Droid-M1"
    mkdir -p "$mountpoint"
    exec ${pkgs.adbfs-rootless}/bin/adbfs "$mountpoint" -d
  '';
in {
  home.packages =
    lib.attrsets.attrValues {
      inherit
        (pkgs)
        ## Android
        adbfs-rootless
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
      inherit droid-m1;
      leetcode-tui = inputs.leetcode-tui.packages.${hostPlatform.system}.default;
    }
    ++ lib.optionals hostPlatform.isDarwin [
      (lib.custom.mkZbxBin "unxip")
    ];
}
