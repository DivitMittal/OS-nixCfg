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
      allowBroken = mkDefault true;
      allowUnfree = mkDefault true;
      allowUnsupportedSystem = mkDefault true;
      allowInsecure = mkDefault true;
    };
  };
}