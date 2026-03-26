{inputs, ...}: {
  imports =
    [(inputs.import-tree.matchNot ".*/default\\.nix" ./.)]
    ++ [
      inputs.mac-app-util.homeManagerModules.default
    ];
}
