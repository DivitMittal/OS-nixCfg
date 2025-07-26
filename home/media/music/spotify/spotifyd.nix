{pkgs, ...}: {
  programs.spotifyd = {
    enable = false;
    package = pkgs.spotifyd;
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
