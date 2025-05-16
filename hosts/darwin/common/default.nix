{
  config,
  lib,
  self,
  inputs,
  pkgs,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  environment.darwinConfig = self + "/hosts/darwin/${config.networking.hostName}/default.nix";

  networking = {
    knownNetworkServices = ["Wi-Fi"];
    dns = [
      # Cloudflare DNS
      "1.1.1.1"
      "1.0.0.1" # IPv4
      "2606:4700:4700::1111"
      "2606:4700:4700::1001" # IPv6
    ];
    computerName = "${config.networking.hostName}";
  };

  environment.systemPackages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      blueutil # bluetooth cli
      duti # file associations
      ;
  };

  programs.man.enable = true;
  programs.info.enable = true;

  system.activationScripts.postUserActivation.text = lib.mkAfter ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  system.checks = {
    verifyBuildUsers = true;
    verifyNixPath = false;
  };

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null; # Set Git commit hash for darwin-version.
  system.stateVersion = 4;
}
