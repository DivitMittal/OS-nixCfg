{inputs, ...}: {
  imports = [inputs.mac-app-util.homeManagerModules.default];

  targets.darwin.copyApps.enable = false;
}
