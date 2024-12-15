{ lib, pkgs, ... }:

let
  inherit(lib) mkDefault;
in
{
  nix.package = pkgs.nixVersions.latest;

  nix = {
    checkConfig = mkDefault true;
    settings = {
      warn-dirty = mkDefault true;
    };
  };

  nixpkgs.config = {
    allowBroken = mkDefault false;
    allowUnsupportedSystem = mkDefault false;
    allowUnfree = mkDefault true;
    allowInsecure = mkDefault true;
  };
}