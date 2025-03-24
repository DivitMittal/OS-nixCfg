{ config, pkgs, self, ... }:

{
  home.packages = [ pkgs.sops ];

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = (self + /secrets/secrets.yaml);
    defaultSopsFormat = "yaml";
  };
}