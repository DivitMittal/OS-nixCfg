{
  lib,
  config,
  ...
}: {
  networking = {
    nameservers = lib.mkDefault [
      # Cloudflare DNS
      "1.1.1.1"
      "1.0.0.1" # IPv4
      "2606:4700:4700::1111"
      "2606:4700:4700::1001" # IPv6
    ];
    firewall = {
      enable = false;
    };
  };
  users.users = {
    "${config.hostSpec.username}" = {
      isNormalUser = true;
    };
  };
}