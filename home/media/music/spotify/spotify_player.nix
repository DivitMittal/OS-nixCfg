{
  pkgs,
  hostPlatform,
  ...
}: {
  programs.spotify-player = {
    enable = true;
    package =
      if hostPlatform.isDarwin
      then
        (pkgs.spotify-player.override {
          withImage = true;
          withFuzzy = true;

          withAudioBackend = "";
          withDaemon = false;
          withStreaming = false;
          withSixel = false;
          withNotify = false;
          withMediaControl = false;
        }).overrideAttrs (oldAttrs: {
          buildNoDefaultFeatures = true;
        })
      else pkgs.spotify-player;

    settings = {
      client_id = "561a7e0b6be94efc8f25374180fbe62a";
      enable_media_control = true;
      enable_notify = false;
      enable_cover_image_cache = true;
      cover_img_width = 10;
      cover_img_length = 10;
      cover_img_scale = 2;
      playback_format = "          {status} {track} • {artists}\n          {album}\n          {metadata}";

      device = {
        name = "spotify_player";
        device_type = "L1";
        volume = 100;
        bitrate = 320;
        audio_cache = true;
        normalization = false;
        autoplay = true;
      };
      layout = {
        playback_window_position = "Bottom";
      };
    };

    keymaps = [
      {
        command = "None";
        key_sequence = "q";
      }
    ];
  };
}
