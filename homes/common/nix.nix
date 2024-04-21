{ lib, pkgs, ... }:

{
  nix = {
    package = lib.mkDefault pkgs.nixVersions.unstable;
    checkConfig = lib.mkDefault true;
    settings = {
      warn-dirty = lib.mkDefault false;
    };
  };
}