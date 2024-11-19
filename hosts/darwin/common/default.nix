{ config, lib, username, hostname, inputs, ... }:

let
  inherit(lib) mkOption;
in
{
  imports = [
    ./../../common
    ./shells.nix
  ];

  options = let inherit(lib) types; in {
    paths.currentDarwinCfg = mkOption {
      type = types.str;
      default = "${config.paths.repo}/hosts/darwin/${hostname}";
      description = "Path to darwin configs";
    };
  };

  config = {
    programs.man.enable  = true;
    programs.info.enable = true;

    networking = {
      knownNetworkServices = [ "Wi-Fi" ];
      # Cloudflare DNS
      dns = [
              "1.1.1.1"              "1.0.0.1"         # IPv4
        "2606:4700:4700::1111" "2606:4700:4700::1001"  # IPv6
      ];
    };

    system.activationScripts.postUserActivation.text = lib.mkAfter ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null; # Set Git commit hash for darwin-version.
    system.stateVersion = 5;
  };
}