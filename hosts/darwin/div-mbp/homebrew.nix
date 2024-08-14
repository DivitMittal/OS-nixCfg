_:

{
  environment.variables = {
    HOMEBREW_NO_ENV_HINTS = "1";
  };

  homebrew = {
    enable = true;

    global.autoUpdate = false;
    onActivation = {
      autoUpdate = true;
      cleanup    = "uninstall";
      extraFlags = ["--verbose"];
    };

    casks = [
      "firefox"                                                               # Internet Browsers
      "visual-studio-code" "jetbrains-toolbox"                                # Development Environment
      "onedrive" "microsoft-auto-update" "microsoft-onenote" "onlyoffice"     # Microsoft & Office Suite Alt
      "raycast" "alt-tab" "spaceman" "syntax-highlight" "gswitch"             # macOS specific
      # "hammerspoon"
      "whatsapp" "telegram"                                                   # Messaging
      "obsidian" "notion-calendar" "notion"                                   # Notes
      "spotify" "stolendata-mpv"                                                        # Multimedia
      "wezterm" "wacom-tablet"
    ];

    brews = [
      "cliclick"
    ];

    masApps = {
      "Texty" = 1538996043;
      # Safari Extensions
      "Ghostery" = 6504861501; # Ad-blocker
      "SuperAgent" = 1568262835; # Cookie Annoyances handler
      "Vimkey" = 1585682577;
    };
  };
}