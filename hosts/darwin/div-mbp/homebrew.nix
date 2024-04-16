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
      ### Internet Browsers
      "floorp" "vivaldi"
      ### Development Environment
      "visual-studio-code" "jetbrains-toolbox"
      ### Microsoft
      "onedrive" "microsoft-auto-update" "microsoft-onenote"
      ### Notes & ToDo
      "obsidian" "notion" "todoist"
      ### Desktop Environment
      "raycast" "alt-tab" "spaceman" "syntax-highlight"

      "thunderbird" "wezterm" "gswitch" "spotify" "onlyoffice"
      # "hammerspoon"
    ];
    brews = [
      "cliclick" "pyenv-virtualenv"
    ];
    # masApps = {};
  };
}