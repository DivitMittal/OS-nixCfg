{ pkgs, ... }:

{
  environment.variables.HOMEBREW_NO_ENV_HINTS = "1";

  homebrew = {
    enable = true;
    brewPrefix = if pkgs.stdenvNoCC.hostPlatform.isAarch64 then "/opt/homebrew/bin" else "/usr/local/bin";

    global.autoUpdate = false;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
      extraFlags = ["--verbose"];
    };

    casks = [
      ## macOS specific
      "raycast" "alt-tab" "spaceman" "gswitch" "bluesnooze"
      #"hammerspoon"

      ## WWWW browser
      "firefox" "google-chrome"

      ## Development Environment
      "wezterm" "visual-studio-code" "jetbrains-toolbox" "cyberduck"

      ## Microsoft
      "onlyoffice" "libreoffice" "microsoft-onenote" "onedrive" "microsoft-auto-update" "microsoft-teams"

      ## Messaging
      "whatsapp"

      ## Notes
      "notion-calendar" "notion"
      #"obsidian"

      ## Multimedia
      "spotify" "stolendata-mpv"

      ## Other
      "wacom-tablet"
    ];

    brews = [
      "cliclick" "spotify_player"
    ];

    masApps = {
      "Texty" = 1538996043;

      # Safari Extensions
      "Ghostery" = 6504861501;
      "SuperAgent" = 1568262835;
      "Vimkey" = 1585682577;
    };
  };
}