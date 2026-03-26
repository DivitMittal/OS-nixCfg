{inputs, ...}: {
  imports = [(inputs.import-tree.matchNot ".*/default\\.nix" ./.)];
}
