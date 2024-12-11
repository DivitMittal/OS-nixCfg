{ pkgs, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  imports = [
    ./spicetify
  ];

  home.packages = builtins.attrValues {
    inherit(pkgs)
      # audio
      spotdl

      # video
      ffmpeg

      # image
      chafa imagemagick exif
    ;
  };

  programs.mpv = {
    enable = true;
    package = if isDarwin then pkgs.hello else pkgs.mpv-unwrapped; # homebrew

    bindings = {
      "n" = "seek -10";
      "i" = "seek +10";
    };

    config = {
      force-window = true;
    };
  };

  programs.spotify-player = {
    enable = true;
    package = if isDarwin then pkgs.hello else pkgs.spotify-player; # homebrew

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