{inputs, ...}: {
  imports =
    [(inputs.import-tree.matchNot ".*/default\\.nix" ./.)]
    ++ [
      inputs.ai-nixCfg.homeManagerConfigurations.default
    ];
}
