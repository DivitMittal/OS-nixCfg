_: {
  networking = {
    nameservers = [
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
}
