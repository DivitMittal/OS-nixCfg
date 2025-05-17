{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  inherit (lib) mkDefault;
in {
  nix.package = mkDefault pkgs.nixVersions.latest;

  nix = {
    enable = true;
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs; # This will add each flake input as a registry
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry; # This will each flake inputs to the system's NIX_PATH env var

    settings = {
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      experimental-features = ["nix-command" "flakes"];
      warn-dirty = mkDefault true;

      use-xdg-base-directories = mkDefault true;
      substituters = [
        "https://divitmittal.cachix.org"
        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
      ];
      trusted-public-keys = [
        "divitmittal.cachix.org-1:Fx7nQrvET1RKTTrxQHMDP/Relbu072af/MFG4BYvpjw="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];

      trusted-users = ["${config.hostSpec.username}"];
    };

    gc = {
      automatic = mkDefault true;
      options = mkDefault "--delete-old";
    };
  };
}
