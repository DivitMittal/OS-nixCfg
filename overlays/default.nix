_: let
  # Import custom overlays once and reuse
  # This is evaluated once per Nix evaluation and cached
  custom-overlays = builtins.import ./custom.nix {};
in {
  flake.overlays = {
    # Named overlays for selective use
    inherit (custom-overlays) custom;
    
    # Default overlay includes all custom packages
    # Consumers can choose to use specific overlays or the default
    default = custom-overlays.custom;
  };
}
