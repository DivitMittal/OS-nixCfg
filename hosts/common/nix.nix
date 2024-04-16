{ lib, pkgs, ...}:

{
  nix = {
    package  = lib.mkDefault pkgs.nix;
    settings = {
      "experimental-features" = ["nix-command" "flakes"];
      "use-xdg-base-directories" = lib.mkDefault true;
      trusted-users = ["root" "div"];
      auto-optimise-store = lib.mkDefault true;
      warn-dirty = lib.mkDefault false;
    };
    gc = {
      automatic = lib.mkDefault true;
      options = "--delete-older-than 1d";
    };
  };
}