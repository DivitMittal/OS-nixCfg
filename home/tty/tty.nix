{inputs, ...}: {
  imports = [
    inputs.ai-nixCfg.homeManagerConfigurations.Cfg
    inputs.TermEmulator-Cfg.homeManagerConfigurations.Cfg
  ];
}
