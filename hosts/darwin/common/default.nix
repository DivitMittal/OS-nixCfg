{
  config,
  lib,
  self,
  pkgs,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  networking = {
    knownNetworkServices = ["Wi-Fi"];
    dns = [
      ## Cloudflare DNS
      # IPv4
      "1.1.1.1"
      "1.0.0.1"
      # IPv6
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
    computerName = "${config.networking.hostName}";
  };

  programs.man.enable = true;
  programs.info.enable = true;

  system.stateVersion = lib.mkDefault 6;
  #environment.darwinConfig = self + "/hosts/darwin/${config.networking.hostName}/default.nix"; # non-flake feature
  system.primaryUser = "${config.hostSpec.username}";
  system.tools = {
    darwin-option.enable = true;
    darwin-rebuild.enable = true;
    darwin-uninstaller.enable = true;
    darwin-version.enable = true;
  };
  system.checks = {
    verifyBuildUsers = true;
    verifyNixPath = false;
  };
  system.configurationRevision = self.rev or self.dirtyRev or null;

  environment.systemPackages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      blueutil # bluetooth cli
      duti # file associations
      ;
  };
}
