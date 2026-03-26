{inputs, ...}: {
  imports = [(inputs.import-tree.matchNot ".*/default\\.nix" ./.)];

  system.stateVersion = 4;
}
