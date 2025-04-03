{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  system.checks = {
    verifyBuildUsers = true;
    verifyNixPath = false;
  };

  networking.hostName = config.hostSpec.hostName;

  time.timeZone = "Asia/Calcutta";
  environment.extraOutputsToInstall = [ "info" ]; # "doc" "devdoc"

  documentation = {
    enable      = true;
    info.enable = true;
    man.enable  = true;
    doc.enable  = false;
  };

  fonts.packages = with pkgs; [ nerd-fonts.caskaydia-cove ];

  environment.systemPackages = builtins.attrValues {
    inherit(pkgs)
      bc gnugrep inetutils gnused gawk which gzip gnutar wget gnupatch gnupg binutils gnumake groff indent diffutils findutils # GNU
      uutils-coreutils-noprefix #uutils-diffutils uutils-findutils # uutils
      zip unzip curl vim git
    ;
  };
}