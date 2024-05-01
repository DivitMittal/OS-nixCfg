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
      "firefox"                                                   # Internet Browsers
      "obsidian" "notion"                                         # Notes & ToDo
      "visual-studio-code" "jetbrains-toolbox"                    # Development Environment
      "onedrive" "microsoft-auto-update" "microsoft-onenote"      # Microsoft
      "raycast" "alt-tab" "spaceman" "syntax-highlight" "gswitch" #"hammerspoon" # macOS DE
      "thunderbird" "wezterm" "spotify" "onlyoffice" "wacom-tablet"
    ];
    brews = [
      "cliclick"
    ];
  };
}