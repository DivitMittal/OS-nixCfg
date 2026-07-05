{
  inputs,
  hostPlatform,
  pkgs,
  ...
}: {
  imports = [inputs.android-kvm.homeManagerModules.android-kvm];

  programs.android-kvm = {
    enable = true;
    package = inputs.android-kvm.packages.${hostPlatform.system}.default;
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
        binary = "${pkgs.scrcpy}/bin/scrcpy";
        audio-enabled = true;
        audio-buffer-ms = 200;
        extra-args = [];
      };
    };
  };
}
