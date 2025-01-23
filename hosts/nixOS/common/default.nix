{ config, pkgs, lib, hostname, ... }:

{
  imports = [
    ./../../common
  ];

  options = let inherit(lib) mkOption types; in {
    paths.currentNixOSCfg = mkOption {
      type = types.str;
      default = "${config.paths.repo}/hosts/nixos/${hostname}";
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

    environment.systemPackages = builtins.attrValues {
      inherit(pkgs)
        dash
      ;
    };
  };
}