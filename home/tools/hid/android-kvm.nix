{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.android-kvm.homeManagerModules.android-kvm];

  programs.android-kvm = {
    enable = true;
    package = inputs.android-kvm.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      android-edge = "right";
      activation-pixels = 24;
      release-pixels = 4;
      poll-interval-ms = 16;
      pointer-scale = 1.0;
      audio-always-on = true;
      adb-binary = "adb";
      control-port = 0;

      scrcpy = {
        binary = "scrcpy";
        audio-enabled = true;
        audio-buffer-ms = 200;
        extra-args = [];
      };
    };
  };
}
