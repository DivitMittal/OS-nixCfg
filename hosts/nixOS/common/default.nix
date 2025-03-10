{ pkgs, config, ... }:

{
  programs.man.enable  = true;
  programs.info.enable = true;

  networking = {
    knownNetworkServices = [ "Wi-Fi" ];
    # Cloudflare DNS
    dns = [
            "1.1.1.1"              "1.0.0.1"         # IPv4
      "2606:4700:4700::1111" "2606:4700:4700::1001"  # IPv6
    ];

    # hostName = "${hostname}"; # handled by easy-hosts
    computerName = "${config.networking.hostName}";
  };

  environment.systemPackages = builtins.attrValues {
    inherit(pkgs)
      dash
    ;
  };
}