{inputs, ...}: {
  flake.overlays = import ./default.nix {inherit inputs;};
}
