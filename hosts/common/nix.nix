{ lib, pkgs, ...}:

{
  nix = {
    package  = lib.mkDefault pkgs.nixVersions.unstable;
    settings = {
      "experimental-features" = ["nix-command" "flakes"];
      "use-xdg-base-directories" = lib.mkDefault true;
      auto-optimise-store = lib.mkDefault true;
      warn-dirty = lib.mkDefault false;
      trusted-users = ["root" "div"];
    };
    gc = {
      automatic = lib.mkDefault true;
      options = "--delete-older-than 1d";
    };
  };
}