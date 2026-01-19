{
  lib,
  inputs,
  ...
}: {
  imports =
    (lib.custom.scanPaths ./.)
    ++ [
      inputs.ai-nixCfg.homeManagerModules.Cfg
    ];
}
