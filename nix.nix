{ lib, pkgs, ... }:

let
  inherit(lib) mkDefault;
in
{
  nix.package = mkDefault pkgs.nixVersions.latest;
  #nixpkgs.hostPlatform = "${pkgs.system}";

  nix = {
    enable = true;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = mkDefault true;

      use-xdg-base-directories = mkDefault false;
      auto-optimise-store = mkDefault false;
    };

    gc = {
      automatic = mkDefault false;
      options = mkDefault "--delete-old";
    };
  };

  nixpkgs.config = {
    allowBroken = mkDefault false;
    allowUnsupportedSystem = mkDefault false;
    allowUnfree = mkDefault true;
    allowInsecure = mkDefault true;
  };
}