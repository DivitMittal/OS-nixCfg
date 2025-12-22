{
  lib,
  inputs,
  ...
}: {
  imports =
    (lib.custom.scanPaths ./.)
    ++ [
      inputs.mac-app-util.homeManagerModules.default
    ];
}
