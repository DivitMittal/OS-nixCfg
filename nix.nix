{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault;
in {
  nix.package = mkDefault pkgs.nixVersions.latest;

  nix = {
    enable = true;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = mkDefault true;

      use-xdg-base-directories = mkDefault false;
      auto-optimise-store = mkDefault false;
      substituters = [
        "https://nix-community.cachix.org"
        "https://divitmittal.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "divitmittal.cachix.org-1:Fx7nQrvET1RKTTrxQHMDP/Relbu072af/MFG4BYvpjw="
      ];
    };

    gc = {
      automatic = mkDefault true;
      options = mkDefault "--delete-old 1";
    };
  };
}