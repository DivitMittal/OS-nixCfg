{inputs, ...}: {
  imports = [
    inputs.ai-nixCfg.homeManagerModules.default
    inputs.TermEmulator-Cfg.homeManagerModules.default
  ];
}
