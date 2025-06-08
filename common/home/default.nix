{
  self,
  lib,
  ...
}: {
  imports = (lib.custom.scanPaths ./.) ++ [self.outputs.homeManagerModules.default];
}
