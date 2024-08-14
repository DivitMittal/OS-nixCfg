{ pkgs, lib, ... }:

let
  fastfetch_macOS = pkgs.fastfetch.overrideAttrs { preBuild = lib.optionalString pkgs.stdenv.isDarwin "export MACOSX_DEPLOYMENT_TARGET=14.0"; };
in
{
  programs.fastfetch = {
    enable = true;
    package = fastfetch_macOS;
  };
}