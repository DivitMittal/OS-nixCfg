{ lib, pkgs, ...}:

{
  nix = {
    package  = lib.mkDefault pkgs.nixVersions.latest;
    settings = {
      "experimental-features" = ["nix-command" "flakes"];
      "use-xdg-base-directories" = lib.mkDefault false;
      warn-dirty = lib.mkDefault false;
      auto-optimise-store = lib.mkDefault false;
    };
    gc = {
      automatic = lib.mkDefault false;
      options = "--delete-older-than 1d";
    };
  };
}