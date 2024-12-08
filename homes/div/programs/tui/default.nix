{ pkgs, ... }:

{
  imports = [
    ./email
    ./weechat
    ./btop.nix
  ];

  home.packages = with pkgs; [
    ttyper
    bandwhich
  ];

  programs.spotify-player = {
    enable = true;
    package = if pkgs.stdenvNoCC.hostPlatform.isDarwin then pkgs.hello else pkgs.spotify-player; # Install via homebrew on Darwin

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

  programs.newsboat = {
    enable = true;

    autoReload = true;
    browser = "open";

    urls = [
      {
        tags = [ "tech" ];
        title = "TechCrunch";
        url = "http://feeds.feedburner.com/TechCrunch/";
      }
      {
        tags = [ "fin" ];
        title = "WSJ";
        url = "https://feeds.a.dj.com/rss/RSSMarketsMain.xml";
      }
    ];
  };
}