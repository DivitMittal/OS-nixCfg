{ lib, pkgs, ... }:

{
  nix = {
    package     = lib.mkDefault pkgs.nixVersions.latest;
    checkConfig = lib.mkDefault true;
    settings = {
      warn-dirty = lib.mkDefault false;
    };
  };

  nixpkgs = {
    config = {
      allowBroken            = lib.mkDefault true;
      allowUnfree            = lib.mkDefault true;
      allowUnsupportedSystem = lib.mkDefault true;
      allowInsecure          = lib.mkDefault true;
    };
  };
}