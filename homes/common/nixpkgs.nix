{ lib, ... }:

{
  nixpkgs = {
    config = {
      allowBroken = lib.mkDefault true;
      allowUnfree = lib.mkDefault true;
      allowUnsupportedSystem = lib.mkDefault true;
      allowInsecure = lib.mkDefault true;
    };
  };
}