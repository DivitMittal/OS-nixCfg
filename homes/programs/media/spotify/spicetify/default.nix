{ pkgs, config, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  imports = [ ./spicetify-cli.nix ];

  programs.spicetify-cli = {
    enable = false;
    package = pkgs.spicetify-cli;

    settings = ''
      [Setting]
      inject_theme_js        = 1
      inject_css             = 1
      check_spicetify_update = 0
      always_enable_devtools = 0
      spotify_path           = ${(if isDarwin then "/Applications/Spotify.app/Contents/Resources" else "")}
      spotify_launch_flags   =
      prefs_path             = ${(if isDarwin then "${config.home.homeDirectory}/Library/Application Support/Spotify/prefs" else "")}
      current_theme          = marketplace
      color_scheme           =
      replace_colors         = 1
      overwrite_assets       = 0

      [Preprocesses]
      disable_sentry     = 1
      disable_ui_logging = 1
      remove_rtl_rule    = 1
      expose_apis        = 1

      [AdditionalOptions]
      extensions            =
      custom_apps           = marketplace|lyrics-plus|history-in-sidebar
      sidebar_config        = 0
      home_config           = 1
      experimental_features = 1
    '';
  };
}