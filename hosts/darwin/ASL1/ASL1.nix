# Apple Silicon Darwin — mirrors L1 service layout
# TODO: extract shared darwin services to common/hosts/darwin/ when configs diverge
_: {
  system.stateVersion = 6;

  imports = [
    ../L1/defaults/defaultsPrefs.nix
    ../L1/programs/homebrew.nix
    ../L1/programs/fuse.nix
    ../L1/programs/wacom.nix
    ../L1/services/kanata.nix
    ../L1/services/spotifyd.nix
    ../L1/services/skhd/skhd.nix
    ../L1/services/yabai.nix
  ];
}
