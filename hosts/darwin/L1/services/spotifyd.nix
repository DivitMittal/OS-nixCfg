_: {
  services.spotify-daemon = {
    enable = false;
    package = null;

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