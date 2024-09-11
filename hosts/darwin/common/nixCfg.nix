{ lib, pkgs, ...}:

{
  nixpkgs.hostPlatform = "x86_64-darwin";

  services.nix-daemon.enable = true;

  environment.systemPackages = with pkgs; [ nixfmt-rfc-style ];

  nix = {
    package = lib.mkDefault pkgs.nixVersions.latest;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = lib.mkDefault true;

      use-xdg-base-directories = lib.mkDefault false;
      auto-optimise-store = lib.mkDefault false;
    };

    gc = {
      automatic = lib.mkDefault false;
      options = "--delete-old";
    };
  };

  nixpkgs.config = {
    allowBroken = lib.mkDefault true;
    allowUnfree = lib.mkDefault true;
    allowUnsupportedSystem = lib.mkDefault true;
    allowInsecure = lib.mkDefault true;
  };

  system.checks = {
    verifyBuildUsers = true;
    verifyNixChannels = true;
    verifyNixPath = true;
  };
}