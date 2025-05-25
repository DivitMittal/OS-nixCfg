{
  lib,
  hostPlatform,
  ...
}: let
  inherit (lib) mkDefault;
in {
  nix.optimise.dates = mkDefault ["Sun 22:00"];

  nixpkgs.hostPlatform = hostPlatform.system;
}
