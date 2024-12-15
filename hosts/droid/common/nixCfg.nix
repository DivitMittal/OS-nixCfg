{ pkgs, lib, ...}:

let
  inherit(lib) mkDefault;
in
{
  nix.package =  pkgs.nixVersions.latest;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
