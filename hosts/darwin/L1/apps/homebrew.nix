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
      "r-lib/rig" #rig
      "aaronraimist/tap" #gomuks
      "macos-fuse-t/homebrew-cask" #fuse-t
      "homebrew/services"
    ];

    casks = [
      ## macOS specific
      "raycast" "alt-tab" "spaceman" "gswitch"
      "bluesnooze"
      #"jordanbaird-ice" # open-source alt to bartender
      "fuse-t" #"macfuse"
      #"betterdisplay"
      #"knockknock"
      #"hammerspoon"

      ## WWWW browser
      "firefox" "google-chrome"
      #"tor-browser"

      ## Development Environment
      "wezterm" "visual-studio-code"
      #"cursor"
      #"jetbrains-toolbox"

      # R
      "rig" "rstudio"

      ## Microsoft
      "onlyoffice"
      "microsoft-auto-update" "microsoft-onenote" "microsoft-teams" "microsoft-outlook" #"microsoft-excel"
      "onedrive"
      #"crystalfetch"
      #"libreoffice"

      ## Communication
      "whatsapp" "thunderbird"
      #"simplex"
      #"zoom"

      ## Networking
      "localsend"
      #"cyberduck"

      ## Multimedia
      "stolendata-mpv"
      #"spotify"

      ## Creative
      "wacom-tablet"
      "musescore"
      "reaper"
      #"blender"

      ## Data Analytics
      #"tableau" "tableau-prep"

      ## Notes
      "obsidian"
      #"notion-calendar" "notion"
    ];

    brews = [
      ## homebrew
      "gh"

      ## macOS-specific
      "cliclick"

      ## Multimedia
      "spotify_player"

      ## Communication
      "gomuks" # Matrix protocol

      ## Development
      "libomp" # Multiprogramming
    ];

    masApps = {
      "Texty" = 1538996043;
      #"Tuner" = 1597107926;
      #PerplexityAI" = 6714467650;

      # Safari Extensions
      "Ghostery" = 6504861501;
      "SuperAgent" = 1568262835;
      "Vimkey" = 1585682577;
    };
  };
}