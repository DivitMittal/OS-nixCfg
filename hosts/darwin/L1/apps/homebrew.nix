_: {
  homebrew = {
    enable = true;
    taps = [
      #"homebrew/services"
      "macos-fuse-t/homebrew-cask" #fuse-t
      #"r-lib/rig" #rig
      #"aaronraimist/tap" #gomuks
    ];

    casks = [
      ## macOS specific
      #"raycast" "alt-tab"
      #"spaceman"
      #"gswitch"
      #"bluesnooze"
      #"monolingual"
      "fuse-t" #"macfuse"
      #"jordanbaird-ice" # open-source alt to bartender
      #"betterdisplay"
      #"knockknock"
      #"hammerspoon"

      ## WWWW browser
      #{
      #  name = "firefox";
      #  args = {appdir = "~/Applications/Homebrew Casks";};
      #}
      #"google-chrome"
      #"tor-browser"

      ## Development Environment
      #"wezterm"
      #"visual-studio-code"
      #"cursor"
      #"jetbrains-toolbox"

      ## R
      #"rig" #"rstudio"

      ## Microsoft
      #"onlyoffice"
      #"microsoft-auto-update"
      #"microsoft-onenote"
      #"microsoft-teams"
      #"microsoft-outlook" #"microsoft-excel"
      #"onedrive"
      #"crystalfetch"
      #"libreoffice"

      ## Communication
      #"whatsapp"
      #"thunderbird"
      #"simplex"
      #"zoom"

      ## Networking
      #"localsend"
      #"cyberduck"

      ## Multimedia
      #"stolendata-mpv"
      #"spotify"

      ## Creative
      {
        name = "wacom-tablet";
        greedy = false;
      }
      #{
      #  name = "musescore";
      #  greedy = true;
      #}
      #"reaper"
      #"blender"

      ## Data Analytics
      #"tableau" "tableau-prep"

      ## Notes
      #"obsidian"
      #"notion-calendar" "notion"
    ];

    brews = [
      ## homebrew
      #"gh"

      ## macOS-specific
      #"cliclick"

      ## Multimedia
      #"spotify_player"

      ## Communication
      #"gomuks" # Matrix protocol

      ## Development
      #"libomp" # Multiprogramming
    ];

    masApps = {
      ## General
      #"Texty" = 1538996043;
      #"Tuner" = 1597107926;
      #"PerplexityAI" = 6714467650;

      ## Safari Extensions
      #"Ghostery" = 6504861501;
      #"SuperAgent" = 1568262835;
      #"Vimkey" = 1585682577;
    };
  };
}