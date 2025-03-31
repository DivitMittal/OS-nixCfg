{ config, ... }:

{
  services.spotify-daemon = {
    enable = false;
    package = /${config.hostSpec.home}/.cargo/bin/spotifyd; # impure

    settings = {
      global = {
        device_type = "computer";
        bitrate = 320;
        initial_volume = 100;
        volume_normalisation = false;
        normalisation_pregain = 0;
      };
    };
  };
}