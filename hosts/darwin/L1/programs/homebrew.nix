{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "brew-ultimate" ''
      echo "Running brew update..."
      brew update

      echo "Running brew upgrade..."
      brew upgrade

      echo "Running brew autoremove..."
      brew autoremove

      echo "Running brew cleanup..."
      brew cleanup -s --prune=0

      echo "Removing brew cache..."
      rm -rf "$(brew --cache)"

      echo "Brew maintenance complete!"
    '')
  ];

  homebrew = {
    taps = [
      "macos-fuse-t/homebrew-cask" #fuse-t
      #"homebrew/services"
      #"r-lib/rig" #rig
      #"aaronraimist/tap" #gomuks
    ];

    casks = [
      "cloudflare-warp"
      "fuse-t" #"macfuse"
      "blackhole-2ch"

      ## macOS specific
      # "lulu"
      #"raycast" "alt-tab"
      #"spaceman"
      #"gswitch"
      #"bluesnooze"
      #"monolingual"
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
      ## mas
      "mas"

      ## homebrew
      # "gh"

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
      "PerplexityAI" = 6714467650;
      "Mirror" = 1502839586;

      ## Safari Extensions
      #"Ghostery" = 6504861501;
      #"SuperAgent" = 1568262835;
      #"Vimkey" = 1585682577;
    };
  };
}
