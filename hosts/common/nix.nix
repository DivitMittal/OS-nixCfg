{ lib, pkgs, ...}:

{
  nix = {
    package  = lib.mkDefault pkgs.nixVersions.unstable;
    settings = {
      "experimental-features" = ["nix-command" "flakes"];
      "use-xdg-base-directories" = lib.mkDefault true;
      warn-dirty = lib.mkDefault false;
      trusted-users = ["root" "div"];
      auto-optimise-store = lib.mkDefault false;
    };
    gc = {
      automatic = lib.mkDefault false;
      options = "--delete-older-than 1d";
    };
  };
}