{
  lib,
  config,
  pkgs,
  ...
}: {
  networking.hostName = config.hostSpec.hostName;
  time.timeZone = "Asia/Calcutta";

  ## documentation
  documentation = {
    enable = true;
    info.enable = true;
    man.enable = true;
    doc.enable = false;
  };
  environment.extraOutputsToInstall = ["info"]; # "doc" "devdoc"

  fonts.packages = [pkgs.nerd-fonts.caskaydia-cove];

  environment.systemPackages = lib.attrsets.attrValues {
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
      uutils-coreutils-noprefix
      uutils-diffutils # diffutils
      uutils-findutils # findutils
      ## Others
      zip
      unzip
      curl
      vim
      git
      ;
  };
}
