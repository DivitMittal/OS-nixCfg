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
      gnused
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
      diffutils
      findutils
      uutils-coreutils-noprefix #uutils-diffutils uutils-findutils
      ## Others
      zip
      unzip
      curl
      vim
      git
      ;
  };
}
