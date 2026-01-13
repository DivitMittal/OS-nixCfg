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
    # taps = [
    #   #"homebrew/services"
    # ];

    casks = [
      "cloudflare-warp"
      "blackhole-2ch"

      ## macOS specific
      #"lulu"
      #"monolingual"
      #"knockknock"
    ];

    brews = [
      ## mas
      #"mas"
      ## Development
      #"libomp" # Multiprogramming
    ];

    masApps = {
      ## General
      #"Texty" = 1538996043;
      #"PerplexityAI" = 6714467650;

      ## Safari Extensions
      #"Ghostery" = 6504861501;
      #"SuperAgent" = 1568262835;
      #"Vimkey" = 1585682577;
    };
  };
}
