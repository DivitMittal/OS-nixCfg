{ lib, pkgs, ... }:

{
  nix = {
    package = lib.mkDefault pkgs.nixVersions.latest;
    checkConfig = lib.mkDefault true;
    settings = {
      warn-dirty = lib.mkDefault false;
    };
  };
}