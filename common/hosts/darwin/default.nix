{
  self,
  lib,
  ...
}: {
  imports = (lib.custom.scanPaths ./.) ++ [self.outputs.darwinModules.default];
}
