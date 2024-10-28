{ config, username, ... }:

{
  imports = [
    ./skhd.nix
    ./yabai.nix
    ./kanata.nix
  ];

  services.kanata = {
    enable = true;
    package = /Users/${username}/.local/bin/kanata; # impure
  };
}