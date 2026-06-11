{pkgs, ...}: let
  droid-m1 = pkgs.writeShellScriptBin "Droid-M1" ''
    mountpoint="$HOME/mnt/Droid-M1"
    mkdir -p "$mountpoint"
    exec ${pkgs.adbfs-rootless}/bin/adbfs "$mountpoint" -d
  '';
in {
  home.packages = [
    pkgs.adbfs-rootless
    pkgs.android-tools
    pkgs.scrcpy
    droid-m1
  ];
}
