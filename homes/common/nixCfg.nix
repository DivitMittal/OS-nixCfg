{ lib, pkgs, ... }:

let
  inherit(lib) mkDefault;
in
{
  nix = {
    package = mkDefault pkgs.nixVersions.latest;

    checkConfig = mkDefault true;
    settings = {
      warn-dirty = mkDefault true;
    };
  };

  nixpkgs = {
    config = {
      allowBroken = mkDefault false;
      allowUnsupportedSystem = mkDefault false;
      allowUnfree = mkDefault true;
      allowInsecure = mkDefault true;
    };
  };
}