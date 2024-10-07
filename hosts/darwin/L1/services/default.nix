{ username, ... }:

{
  imports = [
    ./skhd.nix
    ./yabai.nix
    ./kanata.nix
  ];

  services.kanata = {
    enable = true;
    cfg = /Users/${username}/Projects/TLTR/kanata/TLTR.kbd;
  };
}