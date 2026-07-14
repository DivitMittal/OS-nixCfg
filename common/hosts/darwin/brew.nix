{
  config,
  hostPlatform,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];

  environment.systemPackages = lib.attrsets.attrValues {
    inherit
      (pkgs.customDarwin)
      zerobrew-bin
      ;

    brew-ultimate = pkgs.writeShellScriptBin "brew-ultimate" ''
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
    '';
  };

  environment.variables = {
    HOMEBREW_NO_ENV_HINTS = "1";
    ## Fix SSL certificate verification for Homebrew
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    GIT_SSL_CAINFO = "/etc/ssl/certs/ca-certificates.crt";
  };

  ## Create system-level gitconfig to fix SSL for all git instances (including Homebrew's)
  environment.etc."gitconfig".text = ''
    [http]
      sslCAInfo = /etc/ssl/certs/ca-certificates.crt
  '';

  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
    prefix =
      if hostPlatform.isAarch
      then "/opt/homebrew"
      else "/usr/local";
    global.autoUpdate = false;
    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
      extraFlags = ["--verbose"];
    };
    caskArgs = {
      require_sha = false;
    };
  };

  nix-homebrew = {
    enable = true;
    enableRosetta =
      if hostPlatform.isAarch
      then true
      else false;
    user = config.hostSpec.username;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
    mutableTaps = true;
    autoMigrate = true;
  };
}
