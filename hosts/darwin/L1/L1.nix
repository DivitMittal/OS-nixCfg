_: {
  # Pre-existing Nix install had nixbld GID 30000; stateVersion 6 changed the default to 350.
  # Pin to actual value to suppress the mismatch error after manually bumping stateVersion.
  ids.gids.nixbld = 30000;
}
