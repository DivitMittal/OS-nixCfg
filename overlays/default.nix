{inputs, ...}: {
  flake.overlay.pkgs = builtins.import ./pkgs.nix {inherit inputs;};
}