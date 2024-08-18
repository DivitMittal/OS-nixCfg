{ lib, pkgs, inputs, ... }:

{
  imports = [
    ./../../common
    ./shells.nix
  ];

  nixpkgs.hostPlatform = "x86_64-darwin";

  services.nix-daemon.enable = true;  # Auto upgrade nix package and the daemon service.

  system.checks = {
    verifyBuildUsers = true;
    verifyNixChannels = true;
    verifyNixPath = true;
  };

  networking = {
    knownNetworkServices = [ "Wi-Fi" ];

    # Cloudflare DNS
    dns = [
            "1.1.1.1"              "1.0.0.1"         # IPv4
      "2606:4700:4700::1111" "2606:4700:4700::1001"  # IPv6
    ];
  };

  # Packages common to all macOS hosts & installed in nix-darwin profile
  environment.systemPackages = builtins.attrValues {
    inherit(pkgs)
      binutils gnumake gnused gawk groff indent     # GNU
      less;
  };

  system.activationScripts.postUserActivation.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null; # Set Git commit hash for darwin-version.
  system.stateVersion = 4;
}