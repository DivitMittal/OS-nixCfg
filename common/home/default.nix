{
  self,
  lib,
  hostPlatform,
  inputs,
  ...
}: {
  imports =
    (lib.custom.scanPaths ./.)
    ++ [
      self.outputs.homeManagerModules.default
    ]
    ++ lib.lists.optionals hostPlatform.isDarwin [
      inputs.mac-app-util.homeManagerModules.default
    ];
}
