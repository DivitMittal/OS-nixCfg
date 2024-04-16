{ lib, pkgs, ... }:

{
  nix = {
    package = lib.mkDefault pkgs.nix;
    checkConfig = lib.mkDefault true;
    settings = {
      warn-dirty = lib.mkDefault false;
    };
  };
}