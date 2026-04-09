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
      wget
      gnupatch
      gnupg
      binutils
      gnumake
      groff
      indent
      ## uutils
      uutils-tar # gnutar
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
      ;
  };
}
