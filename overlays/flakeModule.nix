{inputs, ...}: {
  flake.overlays = builtins.import ./default.nix {inherit inputs;};
}