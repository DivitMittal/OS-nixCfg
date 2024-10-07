{ system, lib, pkgs, ...}:

let
  inherit(lib) mkDefault;
in
{
  nixpkgs.hostPlatform = "${system}";

  services.nix-daemon.enable = true;

  nix = {
    package = mkDefault pkgs.nixVersions.latest;

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
    allowBroken = mkDefault true;
    allowUnfree = mkDefault true;
    allowUnsupportedSystem = mkDefault true;
    allowInsecure = mkDefault true;
  };

  system.checks = {
    verifyBuildUsers = mkDefault true;
    verifyNixChannels = mkDefault true;
    # verifyNixPath = mkDefault true;
  };
}