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
    };

    gc = {
      automatic = mkDefault false;
      options = mkDefault "--delete-old";
    };
  };
}