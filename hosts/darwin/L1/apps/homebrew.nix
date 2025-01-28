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

    taps = [
      "r-lib/rig"
      "macos-fuse-t/homebrew-cask"
    ];

    casks = [
      ## macOS specific
      "raycast" "alt-tab" "spaceman" "gswitch"
      "bluesnooze"
      "fuse-t" #"macfuse"
      #"knockknock"
      #"hammerspoon"

      ## WWWW browser
      "firefox" "google-chrome" "tor-browser"

      ## Development Environment
      "wezterm" "visual-studio-code"
      "cursor"
      #"jetbrains-toolbox"

      # R
      "rig" "rstudio"

      ## Microsoft
      "onlyoffice"
      "microsoft-auto-update" "microsoft-onenote" "microsoft-teams" "microsoft-outlook" "microsoft-excel"
      #"crystalfetch"
      #"libreoffice"
      #"onedrive"

      ## Communication
      "whatsapp" "thunderbird" "simplex"
      #"zoom"

      ## Networking
      #"localsend"
      #"cyberduck"

      ## Multimedia
      "stolendata-mpv" "spotify"

      ## Creative
      "wacom-tablet"
      #"blender"
      "musescore"

      ## Data Analytics
      #"tableau" "tableau-prep"

      ## Notes
      #"notion-calendar" "notion"
      #"obsidian"
    ];

    brews = [
      "cliclick"
      "gh"
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