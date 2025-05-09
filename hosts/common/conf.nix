{lib, ...}: let
  inherit (lib) mkDefault;
in {
  nix.optimise = {
    automatic = mkDefault true;
  };
}
