{ lib, pkgs, inputs, ... }:

{
  imports = [
    ./shells.nix
    ./nixCfg.nix
  ];

  environment.systemPackages = builtins.attrValues {
    inherit(pkgs)
      bc diffutils findutils gnugrep inetutils gnused gawk which gzip gnutar wget gnupatch gnupg binutils gnumake groff indent # GNU
      zip unzip curl vim git uutils-coreutils-noprefix
    ;
  };

  time.timeZone = "Asia/Calcutta";

  networking = {
    knownNetworkServices = [ "Wi-Fi" ];

    # Cloudflare DNS
    dns = [
            "1.1.1.1"              "1.0.0.1"         # IPv4
      "2606:4700:4700::1111" "2606:4700:4700::1001"  # IPv6
    ];
  };

  documentation = {
    enable      = true;

    info.enable = true;
    man.enable  = true;

    doc.enable  = false;
  };
  environment.extraOutputsToInstall = [ "info" ]; # "dev" "devdoc"

  programs.man.enable  = true;
  programs.info.enable = true;


  system.activationScripts.postUserActivation.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null; # Set Git commit hash for darwin-version.
  system.stateVersion = 5;
}