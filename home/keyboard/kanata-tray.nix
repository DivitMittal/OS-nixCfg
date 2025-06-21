{
  pkgs,
  inputs,
  ...
}: let
  configFile = inputs.TLTR + "/kanata/tltr.kbd";
in {
  imports = [inputs.kanata-tray.homeManagerModules.kanata-tray];

  programs.kanata-tray = {
    enable = true;

    settings = {
      general = {
        allow_concurrent_presets = false;
      };
      defaults = {
        kanata_executable = "${pkgs.kanata-with-cmd}/bin/kanata";
        tcp_port = 5830;
      };
      presets = {
        TLTR = {
          kanata_config = "${configFile}";
          autorun = true;
          extra_args = ["--nodelay"];
        };
      };
    };
  };
}