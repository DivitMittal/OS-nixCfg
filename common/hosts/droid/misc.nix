{
  pkgs,
  lib,
  inputs,
  ...
}: {
  system.stateVersion = lib.mkDefault "24.05";

  time.timeZone = "Asia/Calcutta";

  environment.etcBackupExtension = ".bak";
  environment.motd = "";

  environment.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ## GNU
      bc
      gnugrep
      inetutils
      gawk
      which
      gzip
      gnutar
      wget
      gnupatch
      gnupg
      binutils
      gnumake
      groff
      indent
      ## uutils
      uutils-sed # gnused
      uutils-coreutils-noprefix # coreutils
      uutils-diffutils # diffutils
      uutils-findutils # findutils
      ## Others
      zip
      unzip
      curl
      vim
      git
      util-linux
      tzdata
      hostname
      openssh
      ## Nix
      home-manager
      ;
  };
  environment.extraOutputsToInstall = ["info"]; # "doc" "devdoc"

  # Make home-manager use the flake's home-manager
  nix.registry.home-manager.flake = inputs.home-manager;
}
