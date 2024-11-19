{ system, lib, pkgs, ...}:

let
  inherit(lib) mkDefault;
in
{
  environment.systemPackages = builtins.attrValues {
    inherit(pkgs)
      comma
    ;
  };

  nixpkgs.hostPlatform = "${system}";

  services.nix-daemon.enable = true;

  nix = {
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

  system.checks = {
    verifyBuildUsers = mkDefault true;
    verifyNixChannels = mkDefault true;
    # verifyNixPath = mkDefault true;
  };
}