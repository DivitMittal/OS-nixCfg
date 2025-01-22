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
      "macfuse"
      "raycast" "alt-tab" "spaceman" "gswitch"
      "bluesnooze"
      #"hammerspoon"

      ## WWWW browser
      "firefox" "google-chrome" "tor-browser"

      ## Development Environment
      "wezterm"
      "visual-studio-code" "jetbrains-toolbox" "cursor"
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
      "localsend"
      #"cyberduck"

      ## Multimedia
      "stolendata-mpv" "spotify"

      ## Creative
      "wacom-tablet"
      #"blender"

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