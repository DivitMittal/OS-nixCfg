{ config, ... }:

{
  imports = [
    ./kanata-tray.nix
  ];

  services.kanata-tray = {
    enable = true;
    package = /${config.paths.homeDirectory}/.local/bin/kanata-tray; #impure
  };
}