{
  lib,
  config,
  ...
}: let
  inherit (lib) mkDefault;
in {
  system.stateVersion = mkDefault "26.05";

  # Enable building aarch64 packages for nix-on-droid deployment
  # Uses QEMU user-mode emulation via binfmt_misc
  boot.binfmt.emulatedSystems = mkDefault ["aarch64-linux"];

  nix.optimise.dates = mkDefault ["Sun 22:00"];

  users.users = {
    "${config.hostSpec.username}" = {
      isNormalUser = true;
    };
  };
}
