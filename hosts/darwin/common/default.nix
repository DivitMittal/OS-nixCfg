{ config, lib, hostname, inputs, pkgs, ... }:

{
  imports = [
    ./../../common
    ./shells.nix
  ];

  options = let inherit(lib) mkOption types; in {
    paths.currentDarwinCfg = mkOption {
      type = types.str;
      default = "${config.paths.repo}/hosts/darwin/${hostname}";
      description = "Path to darwin configs";
    };
  };

  config = {
    environment.darwinConfig = "${config.paths.currentDarwinCfg}/default.nix";

    networking = {
      knownNetworkServices = [ "Wi-Fi" ];
      # Cloudflare DNS
      dns = [
              "1.1.1.1"              "1.0.0.1"         # IPv4
        "2606:4700:4700::1111" "2606:4700:4700::1001"  # IPv6
      ];
      computerName = "${hostname}";
      hostName = "${hostname}";
    };

    environment.systemPackages = builtins.attrValues {
      inherit(pkgs)
        blueutil
        duti
      ;
    };

    programs.man.enable  = true;
    programs.info.enable = true;

    system.activationScripts.postUserActivation.text = lib.mkAfter ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null; # Set Git commit hash for darwin-version.
    system.stateVersion = 4;
  };
}