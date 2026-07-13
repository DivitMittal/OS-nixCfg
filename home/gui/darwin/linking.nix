{inputs, ...}: {
  imports = [inputs.mac-app-util.homeManagerModules.default];

  # copyApps rsync-copies app bundles (needs App Management permission); we use
  # linkApps (symlink) instead so mac-app-util's sync-trampolines has a source
  # dir (~/Applications/Home Manager Apps) to build real trampolines from.
  targets.darwin.copyApps.enable = false;
  targets.darwin.linkApps.enable = true;
}
