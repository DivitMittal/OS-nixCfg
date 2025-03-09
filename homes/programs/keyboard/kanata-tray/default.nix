{ pkgs, TLTR, ... }:

let
  configFile = "${TLTR}/kanata/kanata.kbd";
in
{
  imports = [ ./kanata-tray.nix ];

  services.kanata-tray = rec {
    enable = true;

    kanataPackage = pkgs.kanata-with-cmd;

    settings = {
      general = {
        allow_concurrent_presets = false;
      };
      defaults = {
        kanata_executable = "${kanataPackage}/bin/kanata";
        tcp_port = 5830;
      };
      presets = {
        TLTR = {
          kanata_config = "${configFile}";
          autorun = true;
          extra_args = [ "--nodelay" ];
        };
      };
    };
  };
}