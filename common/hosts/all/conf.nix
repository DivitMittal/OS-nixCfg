{lib, ...}: let
  inherit (lib) mkDefault;
in {
  nix.optimise.automatic = mkDefault true;

  ## Disable non-flake Nix features
  nix.channel.enable = mkDefault false;
  nixpkgs.flake = {
    setFlakeRegistry = mkDefault false;
    setNixPath = mkDefault false;
  };
}