{ pkgs, ... }:

{
  imports = [
    ./shells.nix
    ./users.nix
  ];

  system.checks = {
    verifyBuildUsers = true;
    #verifyNixPath = true;  # handled by easy-hosts
  };

  #networking.hostName = "${hostname}"; # handled by easy-hosts

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
      bc gnugrep inetutils gnused gawk which gzip gnutar wget gnupatch gnupg binutils gnumake groff indent # GNU
      zip unzip curl vim git uutils-coreutils-noprefix uutils-diffutils uutils-findutils
    ;
  };
}