{ config, ... }:

{
  imports = [
    ./kanata.nix
  ];

  services.kanata = {
    enable = true;
    package = "${config.paths.homeDirectory}/.local/bin/kanata"; # impure
  };
}