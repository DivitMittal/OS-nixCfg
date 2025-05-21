{
  inputs,
  lib,
  ...
}: {
  flake.overlay = {
    lib = builtins.import ./lib.nix {inherit lib;};
    pkgs = builtins.import ./pkgs.nix {inherit inputs;};
  };
}
