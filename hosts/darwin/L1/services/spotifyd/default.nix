{ user, config, ... }:

{
  imports = [
    ./spotifyd.nix
  ];

  services.spotify-daemon = {
    enable = false;
    package = /${config.users.users.${user.username}.home}/.cargo/bin/spotifyd; # impure

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