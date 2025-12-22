_: let
  custom-overlays = builtins.import ./custom.nix {};
in {
  flake.overlays = rec {
    inherit (custom-overlays) custom;
    default = custom;
  };
}
